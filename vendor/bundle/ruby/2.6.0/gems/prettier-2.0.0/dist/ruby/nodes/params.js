"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printRestParam = exports.printKeywordRestParam = exports.printArgsForward = exports.printParams = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { group, hardline, join, indent, line, lineSuffix, softline } = prettier_1.default;
function printRestParamSymbol(symbol) {
    return function printRestParamWithSymbol(path, opts, print) {
        return path.getValue().body[0]
            ? [symbol, path.call(print, "body", 0)]
            : symbol;
    };
}
const printParams = (path, opts, print) => {
    const [reqs, optls, rest, post, kwargs, kwargRest, block] = path.getValue().body;
    let parts = [];
    if (reqs) {
        path.each((reqPath) => {
            // For some very strange reason, if you have a comment attached to a
            // rest_param, it shows up here in the list of required params.
            if (reqPath.getValue().type !== "rest_param") {
                parts.push(print(reqPath));
            }
        }, "body", 0);
    }
    if (optls) {
        parts = parts.concat(path.map((optlPath) => join(" = ", optlPath.map(print)), "body", 1));
    }
    if (rest && rest.type !== "excessed_comma") {
        parts.push(path.call(print, "body", 2));
    }
    if (post) {
        parts = parts.concat(path.map(print, "body", 3));
    }
    if (kwargs) {
        parts = parts.concat(path.map((kwargPath) => {
            if (!kwargPath.getValue()[1]) {
                return kwargPath.call(print, 0);
            }
            return group(join(" ", kwargPath.map(print)));
        }, "body", 4));
    }
    if (kwargRest) {
        parts.push(kwargRest === "nil" ? "**nil" : path.call(print, "body", 5));
    }
    if (block) {
        parts.push(path.call(print, "body", 6));
    }
    const contents = [join([",", line], parts)];
    // You can put an extra comma at the end of block args between pipes to
    // change what it does. Below is the difference:
    //
    // [[1, 2], [3, 4]].each { |x| p x } # prints [1, 2] then [3, 4]
    // [[1, 2], [3, 4]].each { |x,| p x } # prints 1 then 3
    //
    // In ruby 2.5, the excessed comma is indicated by having a 0 in the rest
    // param position. In ruby 2.6+ it's indicated by having an "excessed_comma"
    // node in the rest position. Seems odd, but it's true.
    if (rest === 0 || (rest && rest.type === "excessed_comma")) {
        contents.push(",");
    }
    // If the parent node is a paren then we skipped printing the parentheses so
    // that we could handle them here and get nicer formatting.
    const parentNode = path.getParentNode();
    if (["lambda", "paren"].includes(parentNode.type)) {
        const parts = ["("];
        // If the parent node is a paren and the paren has comments that are
        // attached to the left paren, then we need to print those out explicitly
        // here.
        if (parentNode.type === "paren" && parentNode.lparen.comments) {
            const comments = [];
            // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
            parentNode.lparen.comments.forEach((comment, index) => {
                comment.printed = true;
                comments.push(lineSuffix(`${index === 0 ? " " : ""}#${comment.value}`));
            });
            parts.push(join(hardline, comments));
        }
        return group([...parts, indent([softline, ...contents]), softline, ")"]);
    }
    return group(contents);
};
exports.printParams = printParams;
exports.printArgsForward = (0, utils_1.literal)("...");
exports.printKeywordRestParam = printRestParamSymbol("**");
exports.printRestParam = printRestParamSymbol("*");
