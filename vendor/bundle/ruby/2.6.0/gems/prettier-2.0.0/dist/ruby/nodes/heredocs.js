"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printHeredoc = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { group, lineSuffix, join } = prettier_1.default;
const printHeredoc = (path, opts, print) => {
    const { body, ending } = path.getValue();
    const parts = body.map((part, index) => {
        if (part.type !== "@tstring_content") {
            // In this case, the part of the string is an embedded expression
            return path.call(print, "body", index);
        }
        // In this case, the part of the string is just regular string content
        return join(utils_1.literallineWithoutBreakParent, part.body.split(/\r?\n/));
    });
    // We use a literalline break because matching indentation is required
    // for the heredoc contents and ending. If the line suffix contains a
    // break-parent, all ancestral groups are broken, and heredocs automatically
    // break lines in groups they appear in. We prefer them to appear in-line if
    // possible, so we use a literalline without the break-parent.
    return group([
        path.call(print, "beging"),
        lineSuffix(group([utils_1.literallineWithoutBreakParent, ...parts, ending]))
    ]);
};
exports.printHeredoc = printHeredoc;
