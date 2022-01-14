"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printStmts = exports.printProgram = exports.printComment = exports.printEndContent = exports.printParen = exports.printBodyStmt = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { breakParent, dedent, group, hardline, indent, join, line, literalline, softline, trim } = prettier_1.default;
const printBodyStmt = (path, opts, print) => {
    const [stmts, rescue, elseClause, ensure] = path.getValue().body;
    const parts = [];
    if (!(0, utils_1.isEmptyStmts)(stmts)) {
        parts.push(path.call(print, "body", 0));
    }
    if (rescue) {
        parts.push(dedent([hardline, path.call(print, "body", 1)]));
    }
    if (elseClause) {
        // Before Ruby 2.6, this piece of bodystmt was an explicit "else" node
        /* istanbul ignore next */
        const stmts = elseClause.type === "else"
            ? path.call(print, "body", 2, "body", 0)
            : path.call(print, "body", 2);
        parts.push([dedent([hardline, "else"]), hardline, stmts]);
    }
    if (ensure) {
        parts.push(dedent([hardline, path.call(print, "body", 3)]));
    }
    return group(parts);
};
exports.printBodyStmt = printBodyStmt;
const argNodeTypes = ["args", "args_add_star", "args_add_block"];
const printParen = (path, opts, print) => {
    const contentNode = path.getValue().body[0];
    if (!contentNode) {
        return [path.call(print, "lparen"), ")"];
    }
    let contentDoc = path.call(print, "body", 0);
    // If the content is params, we're going to let it handle its own parentheses
    // so that it breaks nicely.
    if (contentNode.type === "params") {
        return contentDoc;
    }
    // If we have an arg type node as the contents, then it's going to return an
    // array, so we need to explicitly join that content here.
    if (argNodeTypes.includes(contentNode.type)) {
        contentDoc = join([",", line], contentDoc);
    }
    return group([
        path.call(print, "lparen"),
        indent([softline, contentDoc]),
        softline,
        ")"
    ]);
};
exports.printParen = printParen;
const printEndContent = (path) => {
    const { body } = path.getValue();
    return [trim, "__END__", literalline, body];
};
exports.printEndContent = printEndContent;
const printComment = (path, opts) => {
    return opts.printer.printComment(path, opts);
};
exports.printComment = printComment;
const printProgram = (path, opts, print) => {
    return [join(hardline, path.map(print, "body")), hardline];
};
exports.printProgram = printProgram;
const printStmts = (path, opts, print) => {
    const stmts = path.getValue().body;
    // This is a special case where we have only comments inside a statement
    // list. In this case we want to avoid doing any kind of line number
    // tracking and just print out the comments.
    if (stmts.length === 1 &&
        stmts[0].type === "void_stmt" &&
        stmts[0].comments) {
        const nodePath = path;
        const comments = nodePath.map((commentPath) => {
            commentPath.getValue().printed = true;
            return opts.printer.printComment(commentPath, opts);
        }, "body", 0, "comments");
        return [breakParent, join(hardline, comments)];
    }
    const parts = [];
    let lineNo = null;
    stmts.forEach((stmt, index) => {
        if (stmt.type === "void_stmt") {
            return;
        }
        const printed = path.call(print, "body", index);
        if (lineNo === null) {
            parts.push(printed);
        }
        else if (stmt.sl - lineNo > 1 ||
            [stmt.type, stmts[index - 1].type].includes("access_ctrl")) {
            parts.push(hardline, hardline, printed);
        }
        else if (stmt.sl !== lineNo ||
            path.getParentNode().type !== "string_embexpr") {
            parts.push(hardline, printed);
        }
        else {
            parts.push("; ", printed);
        }
        lineNo = stmt.el;
    });
    return parts;
};
exports.printStmts = printStmts;
