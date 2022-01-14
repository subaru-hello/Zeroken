"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getInfoFilepath = exports.getLang = void 0;
const child_process_1 = require("child_process");
const fs_1 = require("fs");
const os_1 = __importDefault(require("os"));
const path_1 = __importDefault(require("path"));
const process_1 = __importDefault(require("process"));
let parserArgs;
if (process_1.default.env.PRETTIER_RUBY_HOST) {
    const [cmd, ...args] = process_1.default.env.PRETTIER_RUBY_HOST.split(" ");
    parserArgs = { cmd, args };
}
// In order to properly parse ruby code, we need to tell the ruby process to
// parse using UTF-8. Unfortunately, the way that you accomplish this looks
// differently depending on your platform.
/* istanbul ignore next */
function getLang() {
    const { env, platform } = process_1.default;
    const envValue = env.LC_ALL || env.LC_CTYPE || env.LANG;
    // If an env var is set for the locale that already includes UTF-8 in the
    // name, then assume we can go with that.
    if (envValue && envValue.includes("UTF-8")) {
        return envValue;
    }
    // Otherwise, we're going to guess which encoding to use based on the system.
    // This is probably not the best approach in the world, as you could be on
    // linux and not have C.UTF-8, but in that case you're probably passing an env
    // var for it. This object below represents all of the possible values of
    // process.platform per:
    // https://nodejs.org/api/process.html#process_process_platform
    return {
        aix: "C.UTF-8",
        android: "C.UTF-8",
        cygwin: "C.UTF-8",
        darwin: "en_US.UTF-8",
        freebsd: "C.UTF-8",
        haiku: "C.UTF-8",
        linux: "C.UTF-8",
        netbsd: "C.UTF-8",
        openbsd: "C.UTF-8",
        sunos: "C.UTF-8",
        win32: ".UTF-8"
    }[platform];
}
exports.getLang = getLang;
// Generate the filepath that should be used to communicate the connection
// information between this process and the parser server.
function getInfoFilepath() {
    return path_1.default.join(os_1.default.tmpdir(), `prettier-ruby-parser-${process_1.default.pid}.info`);
}
exports.getInfoFilepath = getInfoFilepath;
// Create a file that will act as a communication mechanism, spawn a parser
// server with that filepath as an argument, then spawn another process that
// will read that information in order to enable us to connect to it in the
// spawnSync function.
function spawnServer() {
    const tempDir = (0, fs_1.mkdtempSync)(path_1.default.join(os_1.default.tmpdir(), "prettier-plugin-ruby-"));
    const filepath = getInfoFilepath();
    let serverRbPath = path_1.default.join(__dirname, "./server.rb");
    let getInfoJsPath = path_1.default.join(__dirname, "./getInfo.js");
    let cleanupTempFiles;
    if (runningInPnPZip()) {
        // If we're running in a Yarn PnP environment inside a ZIP file, it's not possible to run
        // the Ruby server or the getInfo.js script directly.  Instead, we need to copy them and all
        // the files they depend on to a temporary directory.
        const sourceFiles = [
            "parser/server.rb",
            "parser/getInfo.js",
            "parser/netcat.js",
            "ruby/parser.rb",
            "rbs/parser.rb",
            "haml/parser.rb"
        ];
        serverRbPath = path_1.default.join(tempDir, "parser", "server.rb");
        getInfoJsPath = path_1.default.join(tempDir, "parser", "getInfo.js");
        sourceFiles.forEach((rubyFile) => {
            const destDir = path_1.default.join(tempDir, path_1.default.dirname(rubyFile));
            if (!(0, fs_1.existsSync)(destDir)) {
                (0, fs_1.mkdirSync)(destDir);
            }
            (0, fs_1.copyFileSync)(path_1.default.join(__dirname, "..", rubyFile), path_1.default.join(tempDir, rubyFile));
        });
        cleanupTempFiles = () => {
            [
                getInfoJsPath,
                ...sourceFiles.map((rubyFile) => path_1.default.join(tempDir, rubyFile))
            ].forEach((tmpFilePath) => {
                if ((0, fs_1.existsSync)(tmpFilePath)) {
                    (0, fs_1.unlinkSync)(tmpFilePath);
                }
            });
            sourceFiles.forEach((rubyFile) => {
                const tempSubdir = path_1.default.join(tempDir, path_1.default.dirname(rubyFile));
                if ((0, fs_1.existsSync)(tempSubdir)) {
                    (0, fs_1.rmdirSync)(tempSubdir);
                }
            });
            if ((0, fs_1.existsSync)(tempDir)) {
                (0, fs_1.rmdirSync)(tempDir);
            }
        };
    }
    const server = (0, child_process_1.spawn)("ruby", [serverRbPath, filepath], {
        env: Object.assign({}, process_1.default.env, { LANG: getLang() }),
        detached: true,
        stdio: "inherit"
    });
    server.unref();
    process_1.default.on("exit", () => {
        if ((0, fs_1.existsSync)(filepath)) {
            (0, fs_1.unlinkSync)(filepath);
        }
        if (cleanupTempFiles != null) {
            cleanupTempFiles();
        }
        try {
            if (server.pid) {
                process_1.default.kill(-server.pid);
            }
        }
        catch (e) {
            if (process_1.default.env.PLUGIN_RUBY_CI) {
                throw new Error(`Failed to kill the parser server: ${e}`);
            }
        }
    });
    const info = (0, child_process_1.spawnSync)("node", [getInfoJsPath, filepath]);
    if (info.status !== 0) {
        throw new Error(`
      We failed to spawn our parser server. Please report this error on GitHub
      at https://github.com/prettier/plugin-ruby. The error message was:

        ${info.stderr.toString()}.
    `);
    }
    const [cmd, ...args] = info.stdout.toString().split(" ");
    return { cmd, args };
}
// If we're in a yarn Plug'n'Play environment, then the relative paths being
// used by the parser server and the various scripts used to communicate
// therein are not going to work with its virtual file system.
function runningInPnPZip() {
    return process_1.default.versions.pnp && __dirname.includes(".zip");
}
// Formats and sends a request to the parser server. We use netcat (or something
// like it) here since Prettier requires the results of `parse` to be
// synchronous and Node.js does not offer a mechanism for synchronous socket
// requests.
function parseSync(parser, source) {
    if (!parserArgs) {
        parserArgs = spawnServer();
    }
    const response = (0, child_process_1.spawnSync)(parserArgs.cmd, parserArgs.args, {
        input: `${parser}|${source}`,
        maxBuffer: 15 * 1024 * 1024
    });
    const stdout = response.stdout.toString();
    const stderr = response.stderr.toString();
    const { status } = response;
    // If we didn't receive anything over stdout or we have a bad exit status,
    // then throw whatever we can.
    if (stdout.length === 0 || (status !== null && status !== 0)) {
        throw new Error(stderr || "An unknown error occurred");
    }
    const parsed = JSON.parse(stdout);
    if (parsed.error) {
        const error = new Error(parsed.error);
        if (parsed.loc) {
            error.loc = parsed.loc;
        }
        throw error;
    }
    return parsed;
}
exports.default = parseSync;
