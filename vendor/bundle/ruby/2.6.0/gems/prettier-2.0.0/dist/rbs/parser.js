"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const parseSync_1 = __importDefault(require("../parser/parseSync"));
const parser = {
    // This function is responsible for taking an input string of text and
    // returning to prettier a JavaScript object that is the equivalent AST that
    // represents the code stored in that string. We accomplish this by spawning a
    // new Ruby process of parser.rb and reading JSON off STDOUT.
    parse(text) {
        return (0, parseSync_1.default)("rbs", text);
    },
    astFormat: "rbs",
    // This function handles checking whether or not the source string has the
    // pragma for prettier. This is an optional workflow for incremental adoption.
    hasPragma(text) {
        return /^\s*#[^\S\n]*@(format|prettier)\s*(\n|$)/.test(text);
    },
    // This function is critical for comments and cursor support, and is
    // responsible for returning the index of the character within the source
    // string that is the beginning of the given node.
    locStart(node) {
        return node.location.start_pos;
    },
    // This function is critical for comments and cursor support, and is
    // responsible for returning the index of the character within the source
    // string that is the ending of the given node.
    locEnd(node) {
        return node.location.end_pos;
    }
};
exports.default = parser;
