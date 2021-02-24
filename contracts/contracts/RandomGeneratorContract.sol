pragma solidity >=0.4.16 <0.9.0;

contract RandomGeneratorContract {

    function getRandom(address gambler) public {
        emit RandomGeneratorEvent(gambler);
    }

    event RandomGeneratorEvent(address receiver);

}