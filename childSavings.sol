// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract ChildSavings {
    uint256 public amount;
    uint256 public number_of_deposits;
    uint256 public birthday;
    address payable public child;
    address public father;

    constructor(uint256 _amount, address payable _child, uint256 _birthday) {
        amount = _amount;
        child = _child;
        father = payable(msg.sender);
        birthday = _birthday;
    }

    function getChildAge() public view returns (uint256) {
        uint256 currentAge = (block.timestamp - birthday) / (365 days);
        return currentAge;
    }

    function withdraw() external {
        require(msg.sender == child, "Only the child can invoke this function.");
        require(getChildAge() >= 18, "Child must reach 18 years old to withdraw.");
        child.transfer(amount);
        amount = 0; // Reset the amount after withdrawal
    }

    function deposit() external payable {
        require(msg.sender == father, "Only the father can deposit funds.");
        amount += msg.value;
        number_of_deposits++;
    }
}
