"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const isEmptyStmts_1 = __importDefault(require("./isEmptyStmts"));
function isEmptyBodyStmt(node) {
    return (0, isEmptyStmts_1.default)(node.body[0]) && !node.body.slice(1).some(Boolean);
}
exports.default = isEmptyBodyStmt;
