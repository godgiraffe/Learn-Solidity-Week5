// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract FunctionModifier {
    bool public paused;
    int public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }
    /*
    * 將重複用到的邏輯，寫成 Function Modifier
    **/
    modifier whenContractNotPaused() {
        require(!paused, "contract is paused");
        _;
    }

    function inc() external whenContractNotPaused{
        count +=1;
    }

    function dec() whenContractNotPaused external {
        count -=1;
    }
    // 帶有 args 的 modifier
    modifier cap(uint _num){
        require(_num < 100, "input arg must >= 100");
        _;
    }

    function incBy(uint _x) external whenContractNotPaused cap(_x){
        count += _x;
    }


    /**
    * foo() 的完整執行過程為
    * count += 10;
    * count += 1; ← foo() 的主體
    * count *= 2;
    */
    modifier sandwich() {
        count += 10;
        _;
        count *= 2;
    }

    function foo() external sandwich {
        count += 1;
    }


    modifier lastExcute() {
        _;
        require(count > 0, "sorry, check fail");
        _;
    }

    function boo(int _num) external pure lastExcute {
        count += 8;
        count += _num;
    }
}