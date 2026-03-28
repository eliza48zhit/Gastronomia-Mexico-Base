// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaMexico
 * @dev Registro historico con Likes, Dislikes y Escala de Picante (0-10).
 */
contract GastronomiaMexico {

    struct Plato {
        string nombre;
        string descripcion;
        uint8 picante; // Escala del 0 al 10
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con Tacos al Pastor
        registrarPlato(
            "Tacos al Pastor", 
            "Carne de cerdo marinada con achiote y especias, servida con pina, cebolla y cilantro.",
            3
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        uint8 _picante
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        require(_picante <= 10, "La escala de picante es de 0 a 10");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre,
            descripcion: _descripcion,
            picante: _picante,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        uint8 picante,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.picante, p.likes, p.dislikes);
    }
}
