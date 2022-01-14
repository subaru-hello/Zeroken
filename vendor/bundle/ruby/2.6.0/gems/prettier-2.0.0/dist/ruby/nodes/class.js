"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printSClass = exports.printModule = exports.printClass = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { group, hardline, indent } = prettier_1.default;
const printClass = (path, opts, print) => {
    const [, superclass, bodystmt] = path.getValue().body;
    const parts = ["class ", path.call(print, "body", 0)];
    if (superclass) {
        parts.push(" < ", path.call(print, "body", 1));
    }
    const declaration = group(parts);
    if ((0, utils_1.isEmptyBodyStmt)(bodystmt)) {
        return group([declaration, hardline, "end"]);
    }
    return group([
        declaration,
        indent([hardline, path.call(print, "body", 2)]),
        [hardline, "end"]
    ]);
};
exports.printClass = printClass;
const printModule = (path, opts, print) => {
    const node = path.getValue();
    const declaration = group(["module ", path.call(print, "body", 0)]);
    if ((0, utils_1.isEmptyBodyStmt)(node.body[1])) {
        return group([declaration, hardline, "end"]);
    }
    return group([
        declaration,
        indent([hardline, path.call(print, "body", 1)]),
        hardline,
        "end"
    ]);
};
exports.printModule = printModule;
const printSClass = (path, opts, print) => {
    const bodystmt = path.getValue().body[1];
    const declaration = ["class << ", path.call(print, "body", 0)];
    if ((0, utils_1.isEmptyBodyStmt)(bodystmt)) {
        return group([declaration, hardline, "end"]);
    }
    return group([
        declaration,
        indent([hardline, path.call(print, "body", 1)]),
        hardline,
        "end"
    ]);
};
exports.printSClass = printSClass;
