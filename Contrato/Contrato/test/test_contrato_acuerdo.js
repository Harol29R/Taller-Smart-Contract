const ContratoAcuerdo = artifacts.require("ContratoAcuerdo");

contract("ContratoAcuerdo", (accounts) => {
  const [parte1, parte2] = accounts;

  it("Debería crear un nuevo acuerdo", async () => {
    const contrato = await ContratoAcuerdo.deployed();

    await contrato.crearAcuerdo("Primer Acuerdo", parte2, { from: parte1 });
    const acuerdo = await contrato.acuerdos(0);

    assert.equal(acuerdo.descripcion, "Primer Acuerdo", "La descripción no coincide");
    assert.equal(acuerdo.parte1, parte1, "La parte1 no coincide");
    assert.equal(acuerdo.parte2, parte2, "La parte2 no coincide");
  });

  it("Debería confirmar el acuerdo", async () => {
    const contrato = await ContratoAcuerdo.deployed();

    await contrato.confirmarAcuerdo(0, { from: parte1 });
    const acuerdo = await contrato.acuerdos(0);

    assert.equal(acuerdo.confirmadoParte1, true, "Parte1 no confirmó el acuerdo");
  });

  it("Debería verificar el estado del acuerdo", async () => {
    const contrato = await ContratoAcuerdo.deployed();

    await contrato.confirmarAcuerdo(0, { from: parte2 });
    const estado = await contrato.estadoAcuerdo(0);

    assert.equal(estado, true, "El acuerdo no fue confirmado por ambas partes");
  });
});
