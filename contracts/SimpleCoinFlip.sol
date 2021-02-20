pragma solidity >=0.4.16 <0.9.0;

contract SimpleCoinFlip {

    address private owner;

    constructor() public{
        owner = msg.sender;
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

        // dont use in production!!!
        uint randomNumber = block.timestamp % 2;
        if(randomNumber == flipGuess) {
            // he has won!!!
            emit FlipEvent(msg.sender,"Won!");

            if(2*msg.value >= address(this).balance) {
                msg.sender.transfer(address(this).balance);
                return "YOU WON!!!! (Sadly we dont have enought money to pay you the whole winning amount!";
            }

            msg.sender.transfer(2*msg.value);
            return "YOU WON!!!!";

        }else {
            emit FlipEvent(msg.sender, "Lose");
            return "Oh no! You have lost your money!";
        }
    } 


    // events 
    event FundEvent(address funder, uint amount);

    event WithDrawEvent(uint amount);

    event FlipEvent(address player, string won);
}