// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ViewAndPure {
    uint public num;

    function viewFunc() public returns(uint) {
        uint  an = 1;
        num += an;
        return num;
    }

    function pureFunc() pure public returns(uint){
        uint ac = 8 ;
        return ac;
    }

    function normalFunc()  public returns(uint){
        num = 10;
        uint ac = 3 + num;
        return ac;
    }
}