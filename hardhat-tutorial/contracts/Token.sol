// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;


contract Token {
    string public name = "marketcap-token";
    string public symbol = "MARKET";

    uint256 public totalSupply = 21 * 1000000; // 21 million

    address public owner;

    mapping(address => uint256) balances;

    constructor() {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function transfer(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Not enough tokens");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}