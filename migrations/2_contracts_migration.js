
const rental = artifacts.require("Rental");

module.exports = function(deployer) {
    deployer.deploy(rental);
};