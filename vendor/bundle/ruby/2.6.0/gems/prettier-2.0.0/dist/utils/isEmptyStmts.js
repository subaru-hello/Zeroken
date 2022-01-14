"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function isEmptyStmts(node) {
    return (node &&
        node.type === "stmts" &&
        node.body.length === 1 &&
        node.body[0].type === "void_stmt" &&
        !node.body[0].comments);
}
exports.default = isEmptyStmts;
