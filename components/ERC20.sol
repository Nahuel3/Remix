// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;

import "./SafeMath.sol";

//interface de nuestro token erc20
interface IERC20{

//devuelve la cantidad de tokens que hay existentes
function totalSupply() external view returns (uint256);

//devuelve la cantidad de tokens que tiene una direccion indicada por parametro

function balanceOf(address account) external view returns (uint256);

//devuelve el numero de tokens q el spender (comprador) puede gastar en nombre del propietario(owner)
function allowance (address owner, address spender) external view returns (uint256);

// devuelve un valor booleano resultado de la operacion indicada

function transfer (address recipient, uint256 amount) external  returns(bool);

// devuelve un valor booleano con el resultado de la operacion de gasto
function approve (address spender, uint256 amount) external returns(bool);

//devuelve valor booleando con el resultado de la operacion de paso de una cantidad de tokens usando el metodo allowance()
function transferFrom (address sender, address recipient, uint256 amount) external returns (bool);

//Evento que se debe emitir cuando una cantidad de tokens pase de un origen a un destino
event Transfer(address indexed from, address indexed to, uint256 value);

//Evento que se debe emitir cuando se establece una asignacion con el metodo allowance()
event Approval (address indexed owner, address indexed spender, uint256 value);


}
//funciones del token ERC20
contract ERC20Basic is IERC20{

    string public constant name = "Biwindi";
    string public constant symbol = "BWD";
    uint8 public constant decimals = 2;
    

event Transfer(address indexed from, address indexed to, uint256 tokens);
event Approval (address indexed owner, address indexed spender, uint256 tokens);

using SafeMath for uint256;

mapping (address => uint) balances;
mapping (address => mapping (address =>uint)) allowed;
uint256 totalSupply_;

constructor (uint256 initialSupply) public{
    totalSupply_ = initialSupply;
    balances[msg.sender] = totalSupply_;
}

function totalSupply() public override  view returns (uint256){
    return totalSupply_;
}

function increaseTotalSupply(uint newTokensAmount) public{
    totalSupply_ += newTokensAmount;
    balances[msg.sender] += newTokensAmount;
}

function balanceOf(address tokenOwner) public override view returns (uint256){
    return balances[tokenOwner];
}

function allowance(address owner, address delegate) public override view returns(uint256){
    return allowed[owner][delegate];
}

function transfer(address recipient, uint256 numTokens) public override returns(bool){
    require (numTokens <= balances[msg.sender]);
    balances[msg.sender] = balances[msg.sender].sub(numTokens);
    balances[recipient] = balances[recipient].add(numTokens);
    emit Transfer(msg.sender, recipient, numTokens);
    return true;
}

function approve(address delegate, uint256 numTokens) public override returns(bool){
    allowed[msg.sender][delegate] = numTokens;
    emit Approval(msg.sender, delegate, numTokens);
    return true;
}

function transferFrom(address owner, address buyer, uint256 numTokens) public override returns(bool){
    require(numTokens <= balances[owner]);
    require(numTokens <= allowed[owner][msg.sender]);

    balances[owner] = balances[owner].sub(numTokens);
    allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
    balances[buyer] = balances[buyer].add(numTokens);
    emit Transfer(owner, buyer, numTokens);
    return true;
}

}