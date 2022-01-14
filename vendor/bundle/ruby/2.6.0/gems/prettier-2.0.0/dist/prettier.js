"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// If `RBPRETTIER` is set, then this is being run from the `Prettier::run` ruby
// method. In that case, we need to pull `prettier` from the node_modules
// directly, as it's been shipped with the gem.
/* istanbul ignore next */
// eslint-disable-next-line @typescript-eslint/no-var-requires
const source = require(process.env.RBPRETTIER
    ? "../node_modules/prettier"
    : "prettier");
// Cramming everything together to make it simpler to pull in all of the right
// utilities and builders.
const builders = source.doc.builders;
const exported = { ...builders, ...source.doc.utils, ...source.util };
exports.default = exported;
