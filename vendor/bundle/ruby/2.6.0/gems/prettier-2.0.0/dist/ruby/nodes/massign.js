"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printMRHSNewFromArgs = exports.printMRHSAddStar = exports.printMRHS = exports.printMLHSParen = exports.printMLHSAddStar = exports.printMLHSAddPost = exports.printMLHS = exports.printMAssign = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const { group, indent, join, line, softline } = prettier_1.default;
const printMAssign = (path, opts, print) => {
    let right = path.call(print, "body", 1);
    if (["mrhs_add_star", "mrhs_new_from_args"].includes(path.getValue().body[1].type)) {
        right = group(join([",", line], right));
    }
    const parts = [join([",", line], path.call(print, "body", 0))];
    if (path.getValue().body[0].comma) {
        parts.push(",");
    }
    return group([group(parts), " =", indent([line, right])]);
};
exports.printMAssign = printMAssign;
const printMLHS = (path, opts, print) => {
    return path.map(print, "body");
};
exports.printMLHS = printMLHS;
const printMLHSAddPost = (path, opts, print) => {
    return [
        ...path.call(print, "body", 0),
        ...path.call(print, "body", 1)
    ];
};
exports.printMLHSAddPost = printMLHSAddPost;
const printMLHSAddStar = (path, opts, print) => {
    const parts = ["*"];
    if (path.getValue().body[1]) {
        parts.push(path.call(print, "body", 1));
    }
    return [...path.call(print, "body", 0), parts];
};
exports.printMLHSAddStar = printMLHSAddStar;
const printMLHSParen = (path, opts, print) => {
    if (["massign", "mlhs_paren"].includes(path.getParentNode().type)) {
        // If we're nested in brackets as part of the left hand side of an
        // assignment, i.e., (a, b, c) = 1, 2, 3
        // ignore the current node and just go straight to the content
        return path.call(print, "body", 0);
    }
    const parts = [
        softline,
        join([",", line], path.call(print, "body", 0))
    ];
    if (path.getValue().body[0].comma) {
        parts.push(",");
    }
    return group(["(", indent(parts), [softline, ")"]]);
};
exports.printMLHSParen = printMLHSParen;
const printMRHS = (path, opts, print) => {
    return path.map(print, "body");
};
exports.printMRHS = printMRHS;
const printMRHSAddStar = (path, opts, print) => {
    const [leftDoc, rightDoc] = path.map(print, "body");
    return [...leftDoc, ["*", rightDoc]];
};
exports.printMRHSAddStar = printMRHSAddStar;
const printMRHSNewFromArgs = (path, opts, print) => {
    const parts = path.call(print, "body", 0);
    if (path.getValue().body[1]) {
        parts.push(path.call(print, "body", 1));
    }
    return parts;
};
exports.printMRHSNewFromArgs = printMRHSNewFromArgs;
