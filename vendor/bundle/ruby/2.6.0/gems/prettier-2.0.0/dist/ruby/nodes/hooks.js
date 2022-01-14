"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printEND = exports.printBEGIN = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const { group, indent, line } = prettier_1.default;
// The `BEGIN` and `END` keywords are used to hook into the Ruby process. Any
// `BEGIN` blocks are executed right when the process starts up, and the `END`
// blocks are executed right before exiting.
//
//     BEGIN {
//       # content goes here
//     }
//
//     END {
//       # content goes here
//     }
//
// Interesting side note, you don't use `do...end` blocks with these hooks. Both
// nodes contain one child which is a `stmts` node.
function printHook(name) {
    return function printHookWithName(path, opts, print) {
        return group([
            name,
            " ",
            path.call(print, "body", 0),
            indent([line, path.call(print, "body", 1)]),
            [line, "}"]
        ]);
    };
}
exports.printBEGIN = printHook("BEGIN");
exports.printEND = printHook("END");
