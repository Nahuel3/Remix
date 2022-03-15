// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
import "./ERC20.sol";

contract main{
    //instancia del contrato token
    ERC20Basic private token;

    //owner del contrato
    address public owner;

    //direccion del smart contract
    address public contrato;

    //constructor
    constructor () public{
        token = new ERC20Basic(1000000000000);
        owner = msg.sender;
        contrato = address(this);
    }

         
         //obtener direccion del owner
      function getOwner() public view returns (address){
          return owner;
      }

       //obtener direccion del contrato
      function getContract() public view returns (address){
          return contrato;
      }

      //Comprar tokens (direccion y la cantidad de tokens que vamos a comprar)
      function send_tokens (address _destinario, uint _numTokens) public{
          token.transfer(_destinario, _numTokens);
      }

     

      // obtenemos el balance de tokens de wallet
      function balance_direccion (address _direccion) public view returns (uint){
        return token.balanceOf(_direccion);
      }

      //obtenemos el total del token que hay en el smart contract
      function balance_total() public view returns (uint){
          return token.balanceOf(contrato);
      }

    address public a1 = 0x939028D1c8B72DeBEB33B05b191a4E758cfC4630;
    address public a2 = 0x194C0ae22293908FE57937Da1ab445C231c9Eb82;
  

       // Set team addresses
    function setAddresses(address[] memory _a) public  {
        a1 = _a[0];
        a2 = _a[1];
     
    }

    // Withdraw funds from contract for the team
    function withdrawTeam(uint256 amount) public payable  {
        uint256 percent = amount / 100;
        require(payable(a1).send(percent * 50));
        require(payable(a2).send(percent * 50));
        
    }


}