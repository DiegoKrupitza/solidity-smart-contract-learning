pragma solidity >=0.4.16 <0.9.0;

contract HelloWorld {
  
  string private name = "Diego";

  function hello() public view returns(string memory) {
    return string(abi.encodePacked("Hello ", name, "!"));
  }

  function set(string memory _name) public {
    name = _name;
  }

}

