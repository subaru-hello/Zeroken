"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const alias_1 = require("./nodes/alias");
const aref_1 = require("./nodes/aref");
const args_1 = require("./nodes/args");
const arrays_1 = require("./nodes/arrays");
const assign_1 = require("./nodes/assign");
const blocks_1 = require("./nodes/blocks");
const calls_1 = require("./nodes/calls");
const case_1 = require("./nodes/case");
const class_1 = require("./nodes/class");
const commands_1 = require("./nodes/commands");
const conditionals_1 = require("./nodes/conditionals");
const constants_1 = require("./nodes/constants");
const flow_1 = require("./nodes/flow");
const hashes_1 = require("./nodes/hashes");
const heredocs_1 = require("./nodes/heredocs");
const hooks_1 = require("./nodes/hooks");
const ints_1 = require("./nodes/ints");
const lambdas_1 = require("./nodes/lambdas");
const loops_1 = require("./nodes/loops");
const massign_1 = require("./nodes/massign");
const methods_1 = require("./nodes/methods");
const operators_1 = require("./nodes/operators");
const params_1 = require("./nodes/params");
const patterns_1 = require("./nodes/patterns");
const regexp_1 = require("./nodes/regexp");
const rescue_1 = require("./nodes/rescue");
const return_1 = require("./nodes/return");
const statements_1 = require("./nodes/statements");
const strings_1 = require("./nodes/strings");
const super_1 = require("./nodes/super");
const undef_1 = require("./nodes/undef");
const nodes = {
    "@__end__": statements_1.printEndContent,
    "@CHAR": strings_1.printChar,
    "@comment": statements_1.printComment,
    "@int": ints_1.printInt,
    access_ctrl: methods_1.printAccessControl,
    alias: alias_1.printAlias,
    aref: aref_1.printAref,
    aref_field: aref_1.printArefField,
    arg_paren: args_1.printArgParen,
    args: args_1.printArgs,
    args_add_block: args_1.printArgsAddBlock,
    args_add_star: args_1.printArgsAddStar,
    args_forward: params_1.printArgsForward,
    array: arrays_1.printArray,
    aryptn: patterns_1.printAryPtn,
    assign: assign_1.printAssign,
    assoc_new: hashes_1.printAssocNew,
    assoc_splat: hashes_1.printAssocSplat,
    assoclist_from_args: hashes_1.printHashContents,
    bare_assoc_hash: hashes_1.printHashContents,
    BEGIN: hooks_1.printBEGIN,
    begin: rescue_1.printBegin,
    binary: operators_1.printBinary,
    blockarg: args_1.printBlockArg,
    block_var: blocks_1.printBlockVar,
    bodystmt: statements_1.printBodyStmt,
    brace_block: blocks_1.printBraceBlock,
    break: flow_1.printBreak,
    call: calls_1.printCall,
    case: case_1.printCase,
    class: class_1.printClass,
    command: commands_1.printCommand,
    command_call: commands_1.printCommandCall,
    const_path_field: constants_1.printConstPath,
    const_path_ref: constants_1.printConstPath,
    const_ref: constants_1.printConstRef,
    def: methods_1.printDef,
    defs: methods_1.printDef,
    defsl: methods_1.printSingleLineMethod,
    defined: constants_1.printDefined,
    do_block: blocks_1.printDoBlock,
    dot2: operators_1.printDot2,
    dot3: operators_1.printDot3,
    dyna_symbol: strings_1.printDynaSymbol,
    else: conditionals_1.printElse,
    elsif: conditionals_1.printElsif,
    END: hooks_1.printEND,
    ensure: rescue_1.printEnsure,
    fcall: calls_1.printCallContainer,
    fndptn: patterns_1.printFndPtn,
    field: constants_1.printField,
    for: loops_1.printFor,
    hash: hashes_1.printHash,
    heredoc: heredocs_1.printHeredoc,
    hshptn: patterns_1.printHshPtn,
    if: conditionals_1.printIf,
    ifop: conditionals_1.printTernary,
    if_mod: conditionals_1.printIfModifier,
    in: patterns_1.printIn,
    kwrest_param: params_1.printKeywordRestParam,
    lambda: lambdas_1.printLambda,
    massign: massign_1.printMAssign,
    method_add_arg: calls_1.printMethodAddArg,
    method_add_block: calls_1.printMethodAddBlock,
    mlhs: massign_1.printMLHS,
    mlhs_add_post: massign_1.printMLHSAddPost,
    mlhs_add_star: massign_1.printMLHSAddStar,
    mlhs_paren: massign_1.printMLHSParen,
    mrhs: massign_1.printMRHS,
    mrhs_add_star: massign_1.printMRHSAddStar,
    mrhs_new_from_args: massign_1.printMRHSNewFromArgs,
    module: class_1.printModule,
    next: flow_1.printNext,
    opassign: assign_1.printOpAssign,
    params: params_1.printParams,
    paren: statements_1.printParen,
    program: statements_1.printProgram,
    rassign: patterns_1.printRAssign,
    redo: rescue_1.printRedo,
    regexp_literal: regexp_1.printRegexpLiteral,
    rescue: rescue_1.printRescue,
    rescue_ex: rescue_1.printRescueEx,
    rescue_mod: rescue_1.printRescueMod,
    rest_param: params_1.printRestParam,
    retry: rescue_1.printRetry,
    return: return_1.printReturn,
    return0: return_1.printReturn0,
    sclass: class_1.printSClass,
    stmts: statements_1.printStmts,
    string_concat: strings_1.printStringConcat,
    string_dvar: strings_1.printStringDVar,
    string_embexpr: strings_1.printStringEmbExpr,
    string_literal: strings_1.printStringLiteral,
    super: super_1.printSuper,
    symbol_literal: strings_1.printSymbolLiteral,
    top_const_field: constants_1.printTopConst,
    top_const_ref: constants_1.printTopConst,
    unary: operators_1.printUnary,
    undef: undef_1.printUndef,
    unless: conditionals_1.printUnless,
    unless_mod: conditionals_1.printUnlessModifier,
    until: loops_1.printUntil,
    until_mod: loops_1.printUntilModifer,
    var_alias: alias_1.printAlias,
    var_field: assign_1.printVarField,
    var_ref: assign_1.printVarRef,
    vcall: calls_1.printCallContainer,
    when: case_1.printWhen,
    while: loops_1.printWhile,
    while_mod: loops_1.printWhileModifier,
    word: arrays_1.printWord,
    xstring_literal: strings_1.printXStringLiteral,
    yield: flow_1.printYield,
    yield0: flow_1.printYield0,
    zsuper: super_1.printZSuper
};
exports.default = nodes;
