"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printVarRef = exports.printVarField = exports.printOpAssign = exports.printAssign = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { group, indent, join, line } = prettier_1.default;
const printAssign = (path, opts, print) => {
    const [, valueNode] = path.getValue().body;
    const [targetDoc, valueDoc] = path.map(print, "body");
    let rightSideDoc = valueDoc;
    // If the right side of this assignment is a multiple assignment, then we need
    // to join it together with commas.
    if (["mrhs_add_star", "mrhs_new_from_args"].includes(valueNode.type)) {
        rightSideDoc = group(join([",", line], valueDoc));
    }
    if ((0, utils_1.skipAssignIndent)(valueNode)) {
        return group([targetDoc, " = ", rightSideDoc]);
    }
    return group([targetDoc, " =", indent([line, rightSideDoc])]);
};
exports.printAssign = printAssign;
const printOpAssign = (path, opts, print) => {
    return group([
        path.call(print, "body", 0),
        " ",
        path.call(print, "body", 1),
        indent([line, path.call(print, "body", 2)])
    ]);
};
exports.printOpAssign = printOpAssign;
const printVarField = (path, opts, print) => {
    return path.getValue().body ? path.call(print, "body", 0) : "";
};
exports.printVarField = printVarField;
const printVarRef = (path, opts, print) => {
    return path.call(print, "body", 0);
};
exports.printVarRef = printVarRef;
