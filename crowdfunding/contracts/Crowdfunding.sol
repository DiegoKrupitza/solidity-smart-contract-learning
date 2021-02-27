// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Crowdfunding {

    address private owner;

    struct Campaign {
        address owner; // the person who created the campaign and also the person who gets the money!
        uint256 goal; // the amount of money we want to raise
        uint256 endTime; // the timestamp when the campaign ends
        mapping(address => Funder) funder;
    } 

    struct Funder {
        address fundAddress; // the address of the person who gives money
        uint256 amount; 
    }

    mapping(uint256 => Campaign) private campaigns;
    uint256 numberOfCampaigns = 1;


    constructor() public {
        owner = msg.sender;
    }

    function getCampaign(uint256 id) public view returns(string memory) {
        Campaign storage camp = campaigns[id];
        return string(abi.encodePacked("Owner: ",camp.owner, " Goal: ", camp.goal, " Endtime: ", camp.endTime));
    }

    // creation of a campaign
    function create(uint256 goal,uint256 periodOfDay) external returns(uint256) {
        emit Log("Creating new campaign",0);
        uint256 id = numberOfCampaigns++;
        emit Log("Id:", id);

        // assure that campaign does not already exists 
        require(campaigns[id].owner == address(0), "Campaign with the name you provided does already exist!");

        emit Log("Checked if id already exists", id);

        uint256 endTime = block.timestamp + (periodOfDay * 1 days);

        emit Log("New Endtime", id);

        Campaign storage camp = campaigns[id];
        camp.owner = msg.sender;
        camp.goal = goal;
        camp.endTime = endTime;

        emit Log("Creation finished", campaigns[id].goal);

        return id;
    }

    event Log(string message,uint256 id);

}