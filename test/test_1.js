var rental = artifacts.require("Rental");

contract('Rental', async accounts => {

    beforeEach(async () => {
        let instance = await rental.deployed();

        await instance.addOwner("Steven", "7894561239", "0x0255c9291D65059DE3Bd80741680ADEf73595AD8");
        await instance.addTenant("David", "123456789", "7784591263", "0xc9488A5784Eb8473027C2B1817c5B4C7c4d54ea0");
        await instance.addHouse(0, 1, "5846", "Sherbrooke St, Vancouver", 2500, 6);
    });

    it("Add a house", async () => {
        let instance = await rental.deployed();
        let house = await instance.getHouse(0);
        assert.equal(house[0], "5846");
    });
    
    it("View tenant details", async () => {
        let instance = await rental.deployed();
        let tenantDetails = await instance.viewTenantDetails(0, {from: "0x0255c9291D65059DE3Bd80741680ADEf73595AD8"});
        assert.equal(tenantDetails[1], "David");
    });


    it("transfer rental contract", async () => {
        let instance = await rental.deployed();
        
        let tenantId2 = await instance.addTenant("Stacy", "456123789", "7784951263", "0x3F0aD95Fc10c5DAf079fB7365038D5F5FaC2477e");
        let newTenantId = await instance.newTenant(0, 2, 2500, 6, {from: "0x0255c9291D65059DE3Bd80741680ADEf73595AD8"});

        let house = await instance.getHouse(0);
        assert.equal(house[3], 2);
    });


});