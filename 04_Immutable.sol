// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Immutable{
    // 初始定義 immutable owner 後，直接賦值
    // gas 128514 gas
    // transaction cost 111751 gas
    // execution cost 53551 gas
    // address public immutable owner = msg.sender;

    // 初始定義 一般型態的 owner 後，直接賦值
    // gas 154389 gas
    // transaction cost 134251 gas
    // execution cost 75671 gas
    // address public owner = msg.sender;

    // 初始定義 immutable owner 後，在 contructor() 內賦值
    // gas 128535 gas
    // transaction cost 111769 gas
    // execuion cost 53553 gas
    // address public immutable owner;
    // constructor(){
    //     owner = msg.sender;
    // }

    // 初始定義 一般型態的 owner 後，在 contructor() 內賦值
    // gas 154389 gas
    // transaction cost 134251 gas
    // execution cost 75671 gas
    // address public owner;
    // constructor(){
    //     owner = msg.sender;
    // }

    // 初始定義 immutable owner 後，想用 function 賦值，但此操作不成功
    // TypeError: Cannot write to immutable here: Immutable variables can only be initialized inline or assigned directly in the constructor.
    address public immutable owner;
    function setOwner() public {
        owner = msg.sender;
    }
}