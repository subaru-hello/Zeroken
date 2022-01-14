"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printRetry = exports.printRedo = exports.printRescueMod = exports.printRescueEx = exports.printRescue = exports.printEnsure = exports.printBegin = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { align, group, hardline, indent, join, line } = prettier_1.default;
const printBegin = (path, opts, print) => {
    return [
        "begin",
        indent([hardline, path.map(print, "body")]),
        hardline,
        "end"
    ];
};
exports.printBegin = printBegin;
const printEnsure = (path, opts, print) => {
    return [
        path.call(print, "body", 0),
        indent([hardline, path.call(print, "body", 1)])
    ];
};
exports.printEnsure = printEnsure;
const printRescue = (path, opts, print) => {
    const parts = ["rescue"];
    if (path.getValue().body[0]) {
        parts.push(align("rescue ".length, path.call(print, "body", 0)));
    }
    else {
        // If you don't specify an error to rescue in a `begin/rescue` block, then
        // implicitly you're rescuing from `StandardError`. In this case, we're
        // just going to explicitly add it.
        parts.push(" StandardError");
    }
    const bodystmt = path.call(print, "body", 1);
    if (bodystmt.length > 0) {
        parts.push(indent([hardline, bodystmt]));
    }
    // This is the next clause on the `begin` statement, either another
    // `rescue`, and `ensure`, or an `else` clause.
    if (path.getValue().body[2]) {
        parts.push([hardline, path.call(print, "body", 2)]);
    }
    return group(parts);
};
exports.printRescue = printRescue;
// This is a container node that we're adding into the AST that isn't present in
// Ripper solely so that we have a nice place to attach inline comments.
const printRescueEx = (path, opts, print) => {
    const [exception, variable] = path.getValue().body;
    const parts = [];
    if (exception) {
        // If there's just one exception being rescued, then it's just going to be a
        // single doc node.
        let exceptionDoc = path.call(print, "body", 0);
        // If there are multiple exceptions being rescued, then we're going to have
        // multiple doc nodes returned as an array that we need to join together.
        if (["mrhs_add_star", "mrhs_new_from_args"].includes(exception.type)) {
            exceptionDoc = group(join([",", line], exceptionDoc));
        }
        parts.push(" ", exceptionDoc);
    }
    if (variable) {
        parts.push(" => ", path.call(print, "body", 1));
    }
    return group(parts);
};
exports.printRescueEx = printRescueEx;
const printRescueMod = (path, opts, print) => {
    const [statementDoc, valueDoc] = path.map(print, "body");
    return [
        "begin",
        indent([hardline, statementDoc]),
        hardline,
        "rescue StandardError",
        indent([hardline, valueDoc]),
        hardline,
        "end"
    ];
};
exports.printRescueMod = printRescueMod;
exports.printRedo = (0, utils_1.literal)("redo");
exports.printRetry = (0, utils_1.literal)("retry");
