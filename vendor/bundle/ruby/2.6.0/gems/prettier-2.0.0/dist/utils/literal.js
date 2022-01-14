"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function literal(value) {
    return function printLiteral() {
        return value;
    };
}
exports.default = literal;
