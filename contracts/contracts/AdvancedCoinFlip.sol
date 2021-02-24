pragma solidity >=0.4.16 <0.8.0;

import './RandomGeneratorContract.sol';

contract AdvancedCoinFlip {

    address private owner;
    address private randomGeneratorAddress;

    struct Gamble {
        uint8 guess;
        uint256 payin;
    }

    mapping (address => Gamble) private gambleStates;

    constructor(address _randomGeneratorAddress) public{
        owner = msg.sender;
        randomGeneratorAddress = _randomGeneratorAddress;
    }

    // funding 
    function fund() payable public {
        require(msg.value > 0, "Funding value has to be greater than 0");
        emit FundEvent(msg.sender, msg.value);
    }

    // withdraw
    function withdraw(uint amount) public payable {
        require(owner == msg.sender, "You only can withdraw as an owner!");
        
        if(amount >= address(this).balance) {
            msg.sender.transfer(address(this).balance);
        }
        
        msg.sender.transfer(amount);
        emit WithDrawEvent(amount);
    }

    // flip
    function flip(uint8 flipGuess) public payable returns(string memory) {
        require(msg.value >= 1000000000000000000, "You need at least 1eth to play this game!");
        
        // check if flipGuess is either 0 or 1
        require(flipGuess == 0 || flipGuess == 1);

        // store the current gamble state for the user
        gambleStates[msg.sender] = Gamble(flipGuess, msg.value);        
        
        // call generator Contract
        RandomGeneratorContract(randomGeneratorAddress).getRandom(msg.sender);
    } 

    function checkWin(uint8 randomNumber, address gambler) public payable returns(string memory) {
        require(gambleStates[gambler].payin >= 1000000000000000000);

        uint8 flipGuess = gambleStates[gambler].guess;
        uint256 payin = gambleStates[gambler].payin;

        address payable payAdd = address(uint160(gambler));

        gambleStates[gambler].payin = 0;

        if(randomNumber == flipGuess) {
            // he has won!!!
            
            if(2*payin >= address(this).balance) {
                payAdd.transfer(address(this).balance);
                emit FlipEvent(payAdd,"YOU WON!!!! (Sadly we dont have enought money to pay you the whole winning amount!");

                return "YOU WON!!!! (Sadly we dont have enought money to pay you the whole winning amount!";
            }


            payAdd.transfer(2*payin);
            emit FlipEvent(payAdd,"YOU WON!!!!");
            return "YOU WON!!!!";

        }else {
            emit FlipEvent(payAdd, "Lose");
            return "Oh no! You have lost your money!";
        }
    }


    // events 
    event FundEvent(address funder, uint amount);

    event WithDrawEvent(uint amount);

    event FlipEvent(address player, string won);
}