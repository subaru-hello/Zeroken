"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const makeCall = (path, opts, print) => {
    const operation = path.getValue().body[1];
    // Ignoring the next block for coverage information because it's only relevant
    // in Ruby 2.5 and below.
    /* istanbul ignore next */
    if ([".", "&."].includes(operation)) {
        return operation;
    }
    return operation === "::" ? "." : path.call(print, "body", 1);
};
exports.default = makeCall;
