// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// depoly contract 消耗的 gas
// gas : 1075686
// transaction cost : 935379
// execution const : 820335
contract TodoList {
    address public immutable owner;
    constructor(){
        owner = msg.sender;
    }

    // - 定義一個 task struct，包含 name 以及 completed
    struct Task {
        string name;
        bool completed;
    }

    // 一個地址 可以有多個 task
    // mapping(address => Task[]) public tasksByOwner;
    
    // 使用 mapping 取代 array 會比較省 gas
    mapping(address => mapping(uint => Task)) public tasksByOwner;
    // 但因為 mapping 是沒有 length 可以用的，所以要再建一個 mapping 來記錄每個 owner 的 task 數量
    mapping(address => uint) public taskCountsByOwner;

    event TaskCreated(address indexed taskOwner, string taskName, bool completed, uint taskIndex);

    modifier onlyOwner() {
        require(msg.sender == owner, "sorry, you're not contract owner");
        _;
    }

    // - 定義一個 create()，可以新增 task
    // gas : 84197
    // transaction cost : 73214
    // execution const : 51718
    function create(string memory _name) external {
        uint taskIndex = taskCountsByOwner[msg.sender]++;
        Task memory newTask = Task({
            name: _name,
            completed: false
        });
        tasksByOwner[msg.sender][taskIndex] = newTask;
        // return value 會比較耗 gas
        // 使用觸發事件的方式，來通知外部觀察者，會比較省 gas
        emit TaskCreated(msg.sender, _name, false, taskIndex);
        // return (msg.sender, _name, false, taskIndex);
    }


    // - 定義一個 update()，可以修改 task completed 狀態
    // gas : 53466
    // transaction cost : 46492
    // execution const : 25160
    function update(uint _index, bool _completed) external {
        // 檢查輸入的 index 有無存在
        require(_index < taskCountsByOwner[msg.sender], "Index out of bounds");
        // 因為這邊是要修改 state variables, 所以直接用就好了
        tasksByOwner[msg.sender][_index].completed = _completed;
    }

    // - 定義一個 get()，可以輸入 index，查詢 task name & completed 狀態
    // execution const : 8405
    function getTaskInfo(uint _index) view external returns(string memory, bool){
        // 檢查輸入的 index 有無存在
        require(_index < taskCountsByOwner[msg.sender], "Index out of bounds");
        Task storage task =  tasksByOwner[msg.sender][_index];
        return (task.name, task.completed);
    }
    // - 定義一個 kill()，可以砍掉 contract
    function kill() external onlyOwner {
        selfdestruct(payable(owner));
    }
}