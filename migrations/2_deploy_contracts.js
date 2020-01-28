var Election = artifacts.require("./Election.sol");
var FreelanceToken = artifacts.require('./FreelanceToken.sol');
var MarketPlace = artifacts.require('./MarketPlace.sol');

module.exports = function(deployer) {
  deployer.deploy(Election);
  deployer.deploy(FreelanceToken).then(function() {
		return deployer.deploy(MarketPlace, FreelanceToken.address);
	});
};
