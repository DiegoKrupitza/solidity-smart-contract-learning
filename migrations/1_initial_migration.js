const HelloWorld = artifacts.require("HelloWorld");
const Dao = artifacts.require("Dao");

module.exports = function (deployer) {
  deployer.deploy(HelloWorld);
  deployer.deploy(Dao);
};
