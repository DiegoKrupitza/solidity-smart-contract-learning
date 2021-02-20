# solidity-smart-contract-learning

In this repository you can find all the stuff I am coding in my livestream in where I'm trying to learn how to code in solidity.

I hope you enjoy the content and also learn something new with me!

## Usage
In case you want to follow along you need to have `truffle` installed. This is simply done by running `npm install -g truffle`.

In the root directory of this project you now can run the migration (aka deploy the contracts) with the command `truffle migrate`.

If you want to interact with you contracts just simply open a truffle console with `truffle console`.

To interact with the contract `HelloWorld` you need to create and instance of it in the console and then you can call all the functions. 
 
``javascript
let instance = await HelloWorld.deployed(); # creating the instance

instance.hello(); # interacting with the instance
``

In case you want to create a number that is bigger than the max value an int cant hold in js you can use the following.
```javascript
BigInt('10000000000000000000') // 10eth
```

## Live stream
In case you want to catch up on older livestreams you can find them on [youtube](https://www.youtube.com/channel/UCV2ZcyaGGp_tvaGY8XnA3Ow) or on [twitch](https://www.twitch.tv/diegokrupitza).