pragma solidity >=0.4.16 <0.9.0;

contract Dao {

    address private owner;

    // geld abspeichern
    mapping(address => uint) internal balances;

    constructor() public {
        owner = msg.sender;
        balances[msg.sender] = 0;
    }

    // pay
    function pay() public payable {
        uint payed = msg.value;
        address receiver = msg.sender;
        uint oldFunds = balances[receiver];

        if(oldFunds == 0) {
            balances[receiver] = payed;
        }else {
            balances[receiver] = oldFunds + payed;
        }
    }

    // withdraw
    function withdraw(uint amount) public {
        address payable sender = msg.sender;
        uint funds = balances[sender];

        // we cant withdraw more money than we own
        require(funds >= amount, "You cant get more money out than you payed before!");
        require(amount >= 1, "The amount you want to withdraw has to be greater or equal 1");

        uint newFunds = funds - amount;
        balances[sender] = newFunds;

        sender.transfer(amount);
    }
}