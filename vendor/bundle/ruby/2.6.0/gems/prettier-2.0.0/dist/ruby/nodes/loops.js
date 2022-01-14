"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.printUntilModifer = exports.printUntil = exports.printWhileModifier = exports.printWhile = exports.printFor = void 0;
const prettier_1 = __importDefault(require("../../prettier"));
const utils_1 = require("../../utils");
const { align, breakParent, group, hardline, ifBreak, indent, join, softline } = prettier_1.default;
function printLoop(keyword, modifier) {
    return function printLoopWithOptions(path, { rubyModifier }, print) {
        const [, stmts] = path.getValue().body;
        // If the only statement inside this while loop is a void statement, then we
        // can shorten to just displaying the predicate and then a semicolon.
        if ((0, utils_1.isEmptyStmts)(stmts)) {
            return group([
                group([keyword, " ", path.call(print, "body", 0)]),
                hardline,
                "end"
            ]);
        }
        const inlineLoop = (0, utils_1.inlineEnsureParens)(path, [
            path.call(print, "body", 1),
            ` ${keyword} `,
            path.call(print, "body", 0)
        ]);
        // If we're in the modifier form and we're modifying a `begin`, then this is
        // a special case where we need to explicitly use the modifier form because
        // otherwise the semantic meaning changes. This looks like:
        //
        //     begin
        //       foo
        //     end while bar
        //
        // The above is effectively a `do...while` loop (which we don't have in
        // ruby).
        if (modifier && path.getValue().body[1].type === "begin") {
            return inlineLoop;
        }
        const blockLoop = [
            [`${keyword} `, align(keyword.length + 1, path.call(print, "body", 0))],
            indent([softline, path.call(print, "body", 1)]),
            softline,
            "end"
        ];
        // If we're disallowing inline loops or if the predicate of the loop
        // contains an assignment (in which case we can't know for certain that that
        // assignment doesn't impact the statements inside the loop) then we can't
        // use the modifier form and we must use the block form.
        if (!rubyModifier || (0, utils_1.containsAssignment)(path.getValue().body[0])) {
            return [breakParent, blockLoop];
        }
        return group(ifBreak(blockLoop, inlineLoop));
    };
}
const printFor = (path, opts, print) => {
    const [varDoc, rangeDoc, stmtsDoc] = path.map(print, "body");
    const varsDoc = path.getValue().body[0].type === "mlhs" ? join(", ", varDoc) : varDoc;
    return group([
        "for ",
        varsDoc,
        " in ",
        rangeDoc,
        indent([hardline, stmtsDoc]),
        hardline,
        "end"
    ]);
};
exports.printFor = printFor;
exports.printWhile = printLoop("while", false);
exports.printWhileModifier = printLoop("while", true);
exports.printUntil = printLoop("until", false);
exports.printUntilModifer = printLoop("until", true);
