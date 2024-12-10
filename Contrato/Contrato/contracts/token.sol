// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContratoAcuerdo {
    struct Acuerdo {
        uint id;
        string descripcion;
        address parte1;
        address parte2;
        bool confirmadoParte1;
        bool confirmadoParte2;
    }

    mapping(uint => Acuerdo) public acuerdos;
    uint public numeroDeAcuerdos;

    event AcuerdoCreado(
        uint id,
        string descripcion,
        address parte1,
        address parte2
    );

    event AcuerdoConfirmado(
        uint id,
        address parte,
        bool confirmado
    );

    constructor() {
        numeroDeAcuerdos = 0;
    }

    function crearAcuerdo(string memory descripcion, address parte2) public {
        acuerdos[numeroDeAcuerdos] = Acuerdo({
            id: numeroDeAcuerdos,
            descripcion: descripcion,
            parte1: msg.sender,
            parte2: parte2,
            confirmadoParte1: false,
            confirmadoParte2: false
        });

        emit AcuerdoCreado(numeroDeAcuerdos, descripcion, msg.sender, parte2);
        numeroDeAcuerdos++;
    }

    function confirmarAcuerdo(uint id) public {
        Acuerdo storage acuerdo = acuerdos[id];

        require(
            msg.sender == acuerdo.parte1 || msg.sender == acuerdo.parte2,
            "Solo las partes involucradas pueden confirmar el acuerdo."
        );

        if (msg.sender == acuerdo.parte1) {
            acuerdo.confirmadoParte1 = true;
        } else if (msg.sender == acuerdo.parte2) {
            acuerdo.confirmadoParte2 = true;
        }

        emit AcuerdoConfirmado(id, msg.sender, true);
    }

    function estadoAcuerdo(uint id) public view returns (bool) {
        Acuerdo memory acuerdo = acuerdos[id];
        return acuerdo.confirmadoParte1 && acuerdo.confirmadoParte2;
    }
}
