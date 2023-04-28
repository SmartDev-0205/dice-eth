const {GitRevisionPlugin} = require("git-revision-webpack-plugin");

const domain = "dicether.com";

module.exports = {
    domain: domain,
    contractAddress: "0xFb12d6c64cF6573E0BDC078F938Ad261879C6f70",
    serverAddress: "0x437EC7503dFF1b5F5Ab4Dab4455C45a270629f4d",
    apiUrl: `https://api.${domain}/api`,
    websocketUrl: `https://websocket.${domain}`,
    chainId: 4002,
    version: new GitRevisionPlugin().commithash(),
};
