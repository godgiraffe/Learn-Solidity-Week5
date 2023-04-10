// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Selfdestruct {
    // 沒有 payable 的話，就無法在 deploy 時，就打錢到這合約裡
    constructor() payable{}

    function kill () external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns(uint){
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns (uint){
        return address(this).balance;
    }

    function kill(Selfdestruct _kill) external {
        _kill.kill();
    }
}