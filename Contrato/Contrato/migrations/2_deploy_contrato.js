const ContratoAcuerdo = artifacts.require("ContratoAcuerdo");

module.exports = function (deployer) {
  deployer.deploy(ContratoAcuerdo);
};
