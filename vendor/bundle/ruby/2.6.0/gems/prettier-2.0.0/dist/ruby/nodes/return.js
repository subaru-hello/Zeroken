"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printReturn0 = exports.printReturn = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { group, ifBreak, indent, line, join, softline } = prettier_1.default;
// You can't skip the parentheses if you have comments or certain operators with
// lower precedence than the return keyword.
function canSkipParens(args) {
    const stmts = args.body[0].body[0];
    // return(
    //   # a
    //   b
    // )
    if (stmts.comments) {
        return false;
    }
    const stmt = stmts.body[0];
    // return (a or b)
    if (stmt.type === "binary" && ["and", "or"].includes(stmt.body[1])) {
        return false;
    }
    // return (not a)
    if (stmt.type === "unary" && stmt.oper === "not") {
        return false;
    }
    return true;
}
const printReturn = (path, opts, print) => {
    let args = path.getValue().body[0].body[0];
    let steps = ["body", 0, "body", 0];
    if (args.body.length === 1) {
        // If the body of the return contains parens, then just skip directly to the
        // content of the parens so that we can skip printing parens if we don't
        // want them.
        if (args.body[0] && args.body[0].type === "paren" && canSkipParens(args)) {
            args = args.body[0].body[0];
            steps = steps.concat("body", 0, "body", 0);
        }
        // If we're returning an array literal that isn't a special array, single
        // element array, or an empty array, then we want to grab the arguments so
        // that we can print them out as if they were normal return arguments.
        if (args.body[0] &&
            args.body[0].type === "array" &&
            args.body[0].body[0] &&
            args.body[0].body[0].body.length > 1 &&
            ["args", "args_add_star"].includes(args.body[0].body[0].type)) {
            steps = steps.concat("body", 0, "body", 0);
        }
    }
    // Now that we've established which actual node is the arguments to return,
    // we grab it out of the path by diving down the steps that we've set up.
    const parts = path.call(print, ...steps);
    const useBrackets = Array.isArray(parts) && parts.length > 1;
    // If we got the value straight out of the parens, then `parts` would only
    // be a singular doc as opposed to an array.
    const value = Array.isArray(parts) ? join([",", line], parts) : parts;
    // We only get here if we have comments somewhere that would prevent us from
    // skipping the parentheses.
    if (args.body.length === 1 && args.body[0].type === "paren") {
        return ["return", value];
    }
    return group([
        "return",
        ifBreak(useBrackets ? " [" : "(", " "),
        indent([softline, value]),
        softline,
        ifBreak(useBrackets ? "]" : ")", "")
    ]);
};
exports.printReturn = printReturn;
exports.printReturn0 = (0, utils_1.literal)("return");
