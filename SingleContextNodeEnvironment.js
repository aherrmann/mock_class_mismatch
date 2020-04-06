const NodeEnvironment = require("jest-environment-node");

// Workaround for difference in globals between Node and Jest sandbox.
// See https://github.com/facebook/jest/issues/2549#issuecomment-586141607
module.exports = class extends NodeEnvironment {
    constructor(config, context) {
        super(config, context);
        this.global = global;
    }

    runScript(script) {
        return script.runInThisContext();
    }
}
