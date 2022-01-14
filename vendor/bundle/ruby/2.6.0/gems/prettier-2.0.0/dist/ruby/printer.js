"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const prettier_1 = __importDefault(require("../prettier"));
const embed_1 = __importDefault(require("./embed"));
const nodes_1 = __importDefault(require("./nodes"));
const { trim } = prettier_1.default;
const noComments = [
    "args",
    "args_add_block",
    "args_add_star",
    "mlhs",
    "mlhs_add_post",
    "mlhs_add_star",
    "mlhs_paren"
];
const printer = {
    // Certain nodes are used more for organizational purposed than for actually
    // displaying content, so we tell prettier that we don't want comments
    // attached to them.
    canAttachComment(node) {
        return !noComments.includes(node.type);
    },
    embed: embed_1.default,
    // This function tells prettier how to recurse down our AST so that it can
    // find where it needs to attach the comments. The types on this are a little
    // abysmal, but we're going to leave it as is to get this out.
    getCommentChildNodes(node) {
        switch (node.type) {
            case "heredoc":
                return [node.beging];
            case "aryptn":
                return [node.body[0]]
                    .concat(node.body[1])
                    .concat(node.body[2])
                    .concat(node.body[3]);
            case "hshptn": {
                const pairs = node.body[1];
                const values = pairs.reduce((left, right) => left.concat(right), []);
                return [node.body[0]].concat(values).concat(node.body[2]);
            }
            case "params": {
                const [reqs, optls, rest, post, kwargs, kwargRest, block] = node.body;
                let parts = reqs || [];
                (optls || []).forEach((optl) => {
                    parts = parts.concat(optl);
                });
                if (rest) {
                    parts.push(rest);
                }
                parts = parts.concat(post || []);
                (kwargs || []).forEach((kwarg) => {
                    if (kwarg[1]) {
                        parts = parts.concat(kwarg);
                    }
                    else {
                        parts.push(kwarg[0]);
                    }
                });
                if (kwargRest && kwargRest !== "nil") {
                    parts.push(kwargRest);
                }
                if (block) {
                    parts.push(block);
                }
                return parts;
            }
            case "brace_block":
                return [node.body[0], node.body[1], node.beging];
            case "do_block":
                return [node.body[0], node.body[1], node.beging];
            case "paren":
                return [node.lparen, node.body[0]];
            default: {
                if (Array.isArray(node.body)) {
                    return node.body.filter((child) => child && typeof child === "object");
                }
                return [];
            }
        }
    },
    // This is an escape-hatch to ignore nodes in the tree. If you have a comment
    // that includes this pattern, then the entire node will be ignored and just
    // the original source will be printed out.
    hasPrettierIgnore(path) {
        const node = path.getValue();
        return ((node.comments &&
            node.comments.some((comment) => comment.value.includes("prettier-ignore"))) ||
            false);
    },
    // To be honest I'm not 100% sure this function is actually necessary, but it
    // *feels* like a block comment equivalent in JavaScript so I'm going to leave
    // it in place for now.
    isBlockComment(comment) {
        return comment.type === "@embdoc";
    },
    // This function handles adding the format pragma to a source string. This is
    // an optional workflow for incremental adoption.
    insertPragma(text) {
        const boundary = text.startsWith("#") ? "\n" : "\n\n";
        return `# @format${boundary}${text}`;
    },
    // This is the generic node print function, used to convert any node in the
    // AST into its equivalent Doc representation.
    print(path, opts, print) {
        const node = path.getValue();
        const printer = nodes_1.default[node.type];
        if (printer) {
            return printer(path, opts, print);
        }
        if (node.type[0] === "@") {
            return node.body;
        }
        throw new Error(`Unsupported node encountered: ${node.type}`);
    },
    // This is the generic print function for any comment in the AST. It handles
    // both regular comments that begin with a # and embdoc comments, which are
    // surrounded by =begin..=end.
    printComment(path) {
        const comment = path.getValue();
        if (comment.type === "@comment") {
            return `#${comment.value}`;
        }
        return [trim, comment.value];
    }
};
exports.default = printer;
