"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function getTrailingComma(opts) {
    return ["all", "es5"].includes(opts.trailingComma);
}
exports.default = getTrailingComma;
