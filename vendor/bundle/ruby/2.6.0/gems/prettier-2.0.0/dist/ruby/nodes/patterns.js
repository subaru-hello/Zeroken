"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printRAssign = exports.printIn = exports.printHshPtn = exports.printFndPtn = exports.printAryPtn = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const { align, group, hardline, indent, join, line } = prettier_1.default;
const patterns = ["aryptn", "binary", "fndptn", "hshptn", "rassign"];
const printPatternArg = (path, opts, print) => {
    // Pinning is a really special syntax in pattern matching that's not really
    // all that well supported in ripper. Here we're just going to the original
    // source to see if the variable is pinned.
    if (opts.originalText &&
        opts.originalText[opts.locStart(path.getValue()) - 1] === "^") {
        return ["^", path.call(print)];
    }
    return path.call(print);
};
const printAryPtn = (path, opts, print) => {
    const [constant, preargs, splatarg, postargs] = path.getValue().body;
    let argDocs = [];
    if (preargs) {
        argDocs = argDocs.concat(path.map((argPath) => printPatternArg(argPath, opts, print), "body", 1));
    }
    if (splatarg) {
        argDocs.push(["*", path.call(print, "body", 2)]);
    }
    if (postargs) {
        argDocs = argDocs.concat(path.map(print, "body", 3));
    }
    let argDoc = group(join([",", line], argDocs));
    // There are a couple of cases where we _must_ use brackets. They include:
    //
    // * When the number of arguments inside the array pattern is one 1, then we
    //   have to include them, otherwise it matches the whole array. Consider the
    //   difference between `in [elem]` and `in elem`.
    // * If we have a wrapping constant, then we definitely need the brackets.
    //   Consider the difference between `in Const[elem]` and `in Const elem`
    // * If we're nested inside a parent pattern, then we have to have brackets.
    //   Consider the difference between `in key: first, second` and
    //   `in key: [first, second]`.
    if (argDocs.length === 1 ||
        constant ||
        patterns.includes(path.getParentNode().type)) {
        argDoc = ["[", argDoc, "]"];
    }
    if (constant) {
        return [path.call(print, "body", 0), argDoc];
    }
    return argDoc;
};
exports.printAryPtn = printAryPtn;
const printFndPtn = (path, opts, print) => {
    const [constant] = path.getValue().body;
    const docs = [
        "[",
        group(join([",", line], [
            ["*", path.call(print, "body", 1)],
            ...path.map(print, "body", 2),
            ["*", path.call(print, "body", 3)]
        ])),
        "]"
    ];
    if (constant) {
        return [path.call(print, "body", 0), docs];
    }
    return docs;
};
exports.printFndPtn = printFndPtn;
const printHshPtn = (path, opts, print) => {
    const [constant, keyValuePairs, keyValueRest] = path.getValue().body;
    let args = [];
    if (keyValuePairs.length > 0) {
        const printPair = (pairPath) => {
            const parts = [pairPath.call(print, 0)];
            if (pairPath.getValue()[1]) {
                parts.push(" ", pairPath.call((pairValuePath) => printPatternArg(pairValuePath, opts, print), 1));
            }
            return parts;
        };
        args = args.concat(path.map(printPair, "body", 1));
    }
    if (keyValueRest) {
        args.push(["**", path.call(print, "body", 2)]);
    }
    args = group(join([",", line], args));
    if (constant) {
        args = ["[", args, "]"];
    }
    else if (patterns.includes(path.getParentNode().type)) {
        args = ["{ ", args, " }"];
    }
    if (constant) {
        return [path.call(print, "body", 0), args];
    }
    return args;
};
exports.printHshPtn = printHshPtn;
const printIn = (path, opts, print) => {
    const keyword = "in ";
    const parts = [
        keyword,
        align(keyword.length, path.call((valuePath) => printPatternArg(valuePath, opts, print), "body", 0)),
        indent([hardline, path.call(print, "body", 1)])
    ];
    if (path.getValue().body[2]) {
        parts.push(hardline, path.call(print, "body", 2));
    }
    return group(parts);
};
exports.printIn = printIn;
const printRAssign = (path, opts, print) => {
    const { keyword } = path.getValue();
    const [leftDoc, rightDoc] = path.map(print, "body");
    return group([
        leftDoc,
        keyword ? " in" : " =>",
        group(indent([line, rightDoc]))
    ]);
};
exports.printRAssign = printRAssign;
