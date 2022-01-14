"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printZSuper = exports.printSuper = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { align, group, join, line } = prettier_1.default;
const printSuper = (path, opts, print) => {
    const args = path.getValue().body[0];
    if (args.type === "arg_paren") {
        // In case there are explicitly no arguments but they are using parens,
        // we assume they are attempting to override the initializer and pass no
        // arguments up.
        if (args.body[0] === null) {
            return "super()";
        }
        return ["super", path.call(print, "body", 0)];
    }
    const keyword = "super ";
    const argsDocs = path.call(print, "body", 0);
    return group([
        keyword,
        align(keyword.length, group(join([",", line], argsDocs)))
    ]);
};
exports.printSuper = printSuper;
// Version of super without any parens or args.
exports.printZSuper = (0, utils_1.literal)("super");
