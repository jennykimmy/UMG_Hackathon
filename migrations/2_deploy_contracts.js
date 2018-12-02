
var CapitolRecords = artifacts.require("./CapitolRecords.sol");

module.exports = function(deployer) {
  deployer.deploy(CapitolRecords, "test", "ttt", "test artist");
}
