const Web3 = require('web3');

function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max));
}

var web3 = new Web3('ws://localhost:7545');

web3.eth.defaultAccount = '0x6669c791466e5f2A7f350Ef780f888D370478811'
console.log(web3.eth.defaultAccount);

gamble_contract_address = "0x619E9d86573CC00B7e31107C434E269ABaB397b7"
var gambleContract = new web3.eth.Contract([
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_randomGeneratorAddress",
        "type": "address"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "player",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "string",
        "name": "won",
        "type": "string"
      }
    ],
    "name": "FlipEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "funder",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256"
      }
    ],
    "name": "FundEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256"
      }
    ],
    "name": "WithDrawEvent",
    "type": "event"
  },
  {
    "constant": false,
    "inputs": [],
    "name": "fund",
    "outputs": [],
    "payable": true,
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256"
      }
    ],
    "name": "withdraw",
    "outputs": [],
    "payable": true,
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "internalType": "uint8",
        "name": "flipGuess",
        "type": "uint8"
      }
    ],
    "name": "flip",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "payable": true,
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "internalType": "uint8",
        "name": "randomNumber",
        "type": "uint8"
      },
      {
        "internalType": "address",
        "name": "gambler",
        "type": "address"
      }
    ],
    "name": "checkWin",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "payable": true,
    "stateMutability": "payable",
    "type": "function"
  }
],gamble_contract_address);

var myContract = new web3.eth.Contract([
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "receiver",
        "type": "address"
      }
    ],
    "name": "RandomGeneratorEvent",
    "type": "event"
  },
  {
    "constant": false,
    "inputs": [
      {
        "internalType": "address",
        "name": "gambler",
        "type": "address"
      }
    ],
    "name": "getRandom",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  }
], '0x02ACA225e8D9bDE3C279749D791e167ee45483D6');

myContract.events.RandomGeneratorEvent({
  fromBlock: 0
}, function(error, event){ 

    var gamblerAddress = event.returnValues.receiver;

    var randomNumber = getRandomInt(2);

    // send to gamble contract
    gambleContract.methods.checkWin(randomNumber,gamblerAddress).send({
      from: '0x3757ef28603D577a72D1FacB3F4926F9F5E98Aee'
    });

    console.log("Address: " + gamblerAddress + "\tRandomnumber: " + randomNumber);
  }
)
.on('error', console.error);