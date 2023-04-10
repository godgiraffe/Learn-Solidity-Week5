// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// depoly contract 消耗的 gas
// gas : 1165014
// transaction cost : 1013055
// execution const : 892607
contract TodoList {
    address public immutable owner;
    constructor(){
        owner = msg.sender;
    }

    // - 定義一個 task struct，包含 name 以及 completed
    struct Task {
        string name;
        bool completed;
        address owner;
        uint index;
    }

    // 一個地址 可以有多個 task
    // taskList[address] = task[]
    mapping(address => Task[]) public tasksByOwner;


    modifier onlyOwner() {
        require(msg.sender == owner, "sorry, you're not contract owner");
        _;
    }

    // - 定義一個 create()，可以新增 task
    // gas : 130666
    // transaction cost : 113622
    // execution const : 92126
    function create(string memory _name) external  returns(address, string memory, bool, uint){
        uint taskIndex = tasksByOwner[msg.sender].length + 1;
        Task memory newTask = Task({
            owner: msg.sender,
            name: _name,
            completed: false,
            index: taskIndex
        });
        tasksByOwner[msg.sender].push(newTask);
        return (msg.sender, _name, false, taskIndex);
    }


    // - 定義一個 update()，可以修改 task completed 狀態
    // gas : 33914
    // transaction cost : 29490
    // execution const : 8158
    function update(uint _index, bool _completed) external {
        require(_index < tasksByOwner[msg.sender].length, "Index out of bounds");
        // 因為這邊是要修改 state variables, 所以直接用就好了
        tasksByOwner[msg.sender][_index].completed = _completed;
    }
    // - 定義一個 get()，可以輸入 index，查詢 task name & completed 狀態
    // execution const : 11231
    function getTaskInfo(uint _index) view external returns(string memory, bool){
        require(_index < tasksByOwner[msg.sender].length, "Index out of bounds");
        Task[] memory taskList = tasksByOwner[msg.sender];
        return (taskList[_index].name, taskList[_index].completed);
    }
    // - 定義一個 kill()，可以砍掉 contract
    function kill() external onlyOwner {
        selfdestruct(payable(owner));
    }
}