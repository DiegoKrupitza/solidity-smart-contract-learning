const HelloWorld = artifacts.require("HelloWorld");
const Dao = artifacts.require("Dao");
const SimpleCoinFlip = artifacts.require("SimpleCoinFlip");
const RandomGeneratorContract = artifacts.require("RandomGeneratorContract");
const AdvancedCoinFlip = artifacts.require("AdvancedCoinFlip");


module.exports = function (deployer) {
  deployer.deploy(HelloWorld);
  deployer.deploy(Dao);
  deployer.deploy(SimpleCoinFlip);

  // gamble contract with rnadom number
  deployer.deploy(RandomGeneratorContract).then(function() {
    return deployer.deploy(AdvancedCoinFlip, RandomGeneratorContract.address);
  });

};
