"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printUndef = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const { addTrailingComment, align, group, join, line } = prettier_1.default;
const printUndefSymbol = (path, opts, print) => {
    const node = path.getValue();
    // Since we're going to descend into the symbol literal to grab out the ident
    // node, then we need to make sure we copy over any comments as well,
    // otherwise we could accidentally skip printing them.
    if (node.comments) {
        node.comments.forEach((comment) => {
            addTrailingComment(node.body[0], comment);
        });
    }
    return path.call(print, "body", 0);
};
const printUndef = (path, opts, print) => {
    const keyword = "undef ";
    const argNodes = path.map((symbolPath) => printUndefSymbol(symbolPath, opts, print), "body");
    return group([keyword, align(keyword.length, join([",", line], argNodes))]);
};
exports.printUndef = printUndef;
