/**
 *Submitted for verification at BscScan.com on 2022-03-21
*/

/**
 *Submitted for verification at FtmScan.com on 2022-03-11
*/

// SPDX-License-Identifier: MIT 
//https://api.binance.com/api/v3/ticker/price?symbol=BNBBUSD
 
pragma solidity ^0.8;

import "hardhat/console.sol";

contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    function _msgSender() internal view returns (address) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor(){
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract Claimable is Ownable {
    
	function claimETH(uint256 amount) external onlyOwner {
        (bool sent, ) = owner().call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
contract Casino is Claimable {

	using SafeMath for uint256;

    mapping (address => uint256) private results;
    
    uint256 private randomFactor;

	constructor() payable{
		randomFactor = 100;
	}

    function casinoPlay(uint256 predictValue) public payable{
        uint256 randomValue = random();
        randomFactor = randomFactor + (randomValue * 1996)%100000000000;
        if (randomValue <= predictValue){
            uint256 payout = 98500/predictValue;
            uint256 refundValue = msg.value * payout/1000;
            payable(msg.sender).transfer (refundValue);    
        }
        results[msg.sender] = randomValue;
    }

    function random() private view returns (uint256) {
       	uint256 blockValue = uint256(block.number-1 + block.timestamp);
        blockValue = blockValue + uint256(randomFactor);
        uint256 randomValue = uint256(blockValue % 100) + 1;
        return randomValue;
    }

    function getResult() public view returns (uint256){
        return results[msg.sender];
    }

    function withdrawETHs() external onlyOwner {
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success, "Failed to withdraw");
    }

    receive() external payable {
    }

    fallback() external payable {
    }

}


library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;

        return c;
    }
}