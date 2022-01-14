"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printAccessControl = exports.printSingleLineMethod = exports.printDef = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { group, hardline, indent, line } = prettier_1.default;
const printDef = (path, opts, print) => {
    const node = path.getValue();
    const declaration = ["def "];
    let paramsNode;
    let bodystmtNode;
    let nameDoc;
    let paramsDoc;
    let bodystmtDoc;
    if (node.type === "def") {
        paramsNode = node.body[1];
        bodystmtNode = node.body[2];
        nameDoc = path.call(print, "body", 0);
        paramsDoc = path.call(print, "body", 1);
        bodystmtDoc = path.call(print, "body", 2);
    }
    else {
        // In this case, we're printing a method that's defined as a singleton, so
        // we need to include the target and the operator
        declaration.push(path.call(print, "body", 0), path.call(print, "body", 1));
        paramsNode = node.body[3];
        bodystmtNode = node.body[4];
        nameDoc = path.call(print, "body", 2);
        paramsDoc = path.call(print, "body", 3);
        bodystmtDoc = path.call(print, "body", 4);
    }
    // In case there are no parens but there are arguments
    const parens = paramsNode.type === "params" && paramsNode.body.some((type) => type);
    declaration.push(nameDoc, parens ? "(" : "", paramsDoc, parens ? ")" : "");
    if ((0, utils_1.isEmptyBodyStmt)(bodystmtNode)) {
        return group([...declaration, "; end"]);
    }
    return group([
        group(declaration),
        indent([hardline, bodystmtDoc]),
        hardline,
        "end"
    ]);
};
exports.printDef = printDef;
const printSingleLineMethod = (path, opts, print) => {
    const parensNode = path.getValue().body[1];
    let paramsDoc = "";
    if (parensNode) {
        const paramsNode = parensNode.body[0];
        if (paramsNode.body.some((type) => type)) {
            paramsDoc = path.call(print, "body", 1);
        }
    }
    return group([
        "def ",
        path.call(print, "body", 0),
        paramsDoc,
        " =",
        indent(group([line, path.call(print, "body", 2)]))
    ]);
};
exports.printSingleLineMethod = printSingleLineMethod;
const printAccessControl = (path, opts, print) => {
    return path.call(print, "body", 0);
};
exports.printAccessControl = printAccessControl;
