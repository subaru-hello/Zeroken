"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printYield0 = exports.printYield = exports.printNext = exports.printBreak = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { join } = prettier_1.default;
function nodeDive(node, steps) {
    let current = node;
    steps.forEach((step) => {
        current = current[step];
    });
    return current;
}
const unskippableParens = [
    "if_mod",
    "rescue_mod",
    "unless_mod",
    "until_mod",
    "while_mod"
];
function maybeHandleParens(path, print, keyword, steps) {
    const node = nodeDive(path.getValue(), steps);
    if (node.type !== "paren") {
        return null;
    }
    const stmts = node.body[0].body;
    if (stmts.length === 1 && !unskippableParens.includes(stmts[0].type)) {
        return [`${keyword} `, path.call(print, ...steps, "body", 0)];
    }
    return [keyword, path.call(print, ...steps)];
}
const printBreak = (path, opts, print) => {
    const content = path.getValue().body[0];
    if (content.body.length === 0) {
        return "break";
    }
    const steps = ["body", 0, "body", 0, "body", 0];
    return (maybeHandleParens(path, print, "break", steps) || [
        "break ",
        join(", ", path.call(print, "body", 0))
    ]);
};
exports.printBreak = printBreak;
const printNext = (path, opts, print) => {
    const args = path.getValue().body[0].body[0];
    if (!args) {
        return "next";
    }
    const steps = ["body", 0, "body", 0, "body", 0];
    return (maybeHandleParens(path, print, "next", steps) || [
        "next ",
        join(", ", path.call(print, "body", 0))
    ]);
};
exports.printNext = printNext;
const printYield = (path, opts, print) => {
    if (path.getValue().body[0].type === "paren") {
        return ["yield", path.call(print, "body", 0)];
    }
    return ["yield ", join(", ", path.call(print, "body", 0))];
};
exports.printYield = printYield;
exports.printYield0 = (0, utils_1.literal)("yield");
