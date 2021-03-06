const { ethers } = require("hardhat");
const { expect } = require("chai");


describe("Token contract", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("Token");

    const marketcapToken = await Token.deploy();

    const ownerBalance = await marketcapToken.balanceOf(owner.address);
    expect(await marketcapToken.totalSupply()).to.equal(ownerBalance);
  });
});

describe("Transactions", function () {
  it("Should transfer tokens between accounts", async function () {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("Token");

    const marketcapToken = await Token.deploy();

    // Transfer 50 tokens from owner to addr1
    await marketcapToken.transfer(addr1.address, 50);
    expect(await marketcapToken.balanceOf(addr1.address)).to.equal(50);

    // Transfer 50 tokens from addr1 to addr2
    await marketcapToken.connect(addr1).transfer(addr2.address, 50);
    expect(await marketcapToken.balanceOf(addr2.address)).to.equal(50);
  });
});