"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printUnary = exports.printDot3 = exports.printDot2 = exports.printBinary = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { group, indent, line, softline } = prettier_1.default;
const printBinary = (path, opts, print) => {
    const [, operator, rightNode] = path.getValue().body;
    const space = operator === "**" ? "" : " ";
    if (utils_1.noIndent.includes(rightNode.type)) {
        return group([
            group(path.call(print, "body", 0)),
            space,
            operator,
            space,
            group(path.call(print, "body", 2))
        ]);
    }
    return group([
        group(path.call(print, "body", 0)),
        space,
        group(indent([
            operator,
            space === "" ? softline : line,
            path.call(print, "body", 2)
        ]))
    ]);
};
exports.printBinary = printBinary;
// dot2 nodes are used with ranges (or flip-flops). They can optionally drop
// their left side for beginless ranges or their right side for endless ranges.
const printDot2 = (path, opts, print) => {
    const [leftNode, rightNode] = path.getValue().body;
    return [
        leftNode ? path.call(print, "body", 0) : "",
        "..",
        rightNode ? path.call(print, "body", 1) : ""
    ];
};
exports.printDot2 = printDot2;
// dot3 nodes are used with ranges (or flip-flops). They can optionally drop
// their left side for beginless ranges or their right side for endless ranges.
const printDot3 = (path, opts, print) => {
    const [leftNode, rightNode] = path.getValue().body;
    return [
        leftNode ? path.call(print, "body", 0) : "",
        "...",
        rightNode ? path.call(print, "body", 1) : ""
    ];
};
exports.printDot3 = printDot3;
const printUnary = (path, opts, print) => {
    const node = path.getValue();
    const contentsDoc = path.call(print, "body", 0);
    if (node.oper === "not") {
        // Here we defer to the original source, as it's kind of difficult to
        // determine if we can actually remove the parentheses being used.
        if (node.paren) {
            return ["not", "(", contentsDoc, ")"];
        }
        else {
            return ["not", " ", contentsDoc];
        }
    }
    return [node.oper, contentsDoc];
};
exports.printUnary = printUnary;
