"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// If the node is a type of assignment or if the node is a paren and nested
// inside that paren is a node that is a type of assignment.
function containsAssignment(node) {
    if (!node) {
        return false;
    }
    if (["assign", "massign", "opassign"].includes(node.type)) {
        return true;
    }
    const anyNode = node;
    return Array.isArray(anyNode.body) && anyNode.body.some(containsAssignment);
}
exports.default = containsAssignment;
