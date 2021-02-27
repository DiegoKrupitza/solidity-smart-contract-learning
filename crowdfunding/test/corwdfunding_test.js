const Crowdfunding = artifacts.require("Crowdfunding");

contract("Crowdfunding", () => {

    it('should create a new campaign', async () => {

        var instance = await Crowdfunding.deployed();
        var id = await instance.create.sendTransaction(10000,1);

        var info = await instance.getCampaign.sendTransaction(1);
        assert(info !== undefined);
    });
    
});