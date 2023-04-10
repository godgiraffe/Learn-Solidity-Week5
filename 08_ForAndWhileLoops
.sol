// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ForAndWhileLoops {
    function loops() pure external {
        for (uint i = 0; i < 10; i++){
            // ....
            if (i == 3){
                // 跳過這次迴圈
                continue;
            }
            // ....
            if (i == 5){
                // 結束這個迴圈
                break;
            }
        }

        uint j = 0;
        while (j < 10){
            // ...
            j++;
        }
    }

    function sum(uint _n) pure returns(_uint) external {
        uint s;
        for (uint i = 1; i < = _n; i++0){
            s += i;
        }
        return s;
    }
}