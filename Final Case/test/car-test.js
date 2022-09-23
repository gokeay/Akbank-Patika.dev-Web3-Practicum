//KONTRAT TEST

const { expect } = require('chai');
const { ethers } = require('hardhat');
//const provider = ethers.provider;

function ethToNum(val) {
    return Number(ethers.utils.formatEther(val))
}

describe(" --kontrollerini yapacagin kontratin ismini yazabilirsin-- ", function() {
    let owner, user1;
    let Token, token;
    let balances;

    // before, beforeEach, after, afterEach, it

    // before(async function () { //kontrat deploy edilmeden önce bir kere çalıştırılıp ortam hazırlanıyor });

    // beforeEach(async function () { // her "it" blok undan önce gerekli değişiklikleri yapıyor });

    // after(async function () { // kontratın en sonunda son değişiklikleri yapıyor });

    // afterEach(async function () { // her it ten sonra gerekli değişiklikleri yapıyor });

    before(async function () {
        [owner, user1] = await ethers.getSigners();

        Token = await ethers.getContractFactory(" --your token-- ");
        token = await Token.connect(owner).deploy();
    });

    beforeEach(async function() {
        balances = [
            ethToNum(await token.balanceOf(owner.address)),
            ethToNum(await token.balanceOf(user1.address)),
        ]
    });

    it("Deploys the contracts", async function() {
        expect(token.address).to.not.be.undefined; // böyle başka bir adres var mı, bu adres geçerli mi? diye bakar. --> .to.be.properAddress; da kullanilabilir.
    });

})