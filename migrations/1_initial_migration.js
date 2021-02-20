const HelloWorld = artifacts.require("HelloWorld");
const Dao = artifacts.require("Dao");
const SimpleCoinFlip = artifacts.require("SimpleCoinFlip");

module.exports = function (deployer) {
  deployer.deploy(HelloWorld);
  deployer.deploy(Dao);
  deployer.deploy(SimpleCoinFlip);
};
