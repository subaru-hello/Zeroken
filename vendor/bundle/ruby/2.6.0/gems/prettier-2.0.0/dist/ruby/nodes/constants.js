"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printTopConst = exports.printField = exports.printDefined = exports.printConstRef = exports.printConstPath = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { group, indent, join, softline } = prettier_1.default;
const printConstPath = (path, opts, print) => {
    return join("::", path.map(print, "body"));
};
exports.printConstPath = printConstPath;
const printConstRef = (path, opts, print) => {
    return path.call(print, "body", 0);
};
exports.printConstRef = printConstRef;
const printDefined = (path, opts, print) => {
    return group([
        "defined?(",
        indent([softline, path.call(print, "body", 0)]),
        softline,
        ")"
    ]);
};
exports.printDefined = printDefined;
const printField = (path, opts, print) => {
    return group([
        path.call(print, "body", 0),
        (0, utils_1.makeCall)(path, opts, print),
        path.call(print, "body", 2)
    ]);
};
exports.printField = printField;
const printTopConst = (path, opts, print) => {
    return ["::", path.call(print, "body", 0)];
};
exports.printTopConst = printTopConst;
