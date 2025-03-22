pragma solidity ^0.8.0;

contract TaskManager {
    struct Task {
        uint id;
        string description;
        bool completed;
    }

    Task[] public tasks;
    uint public taskCount;
    address public owner;
    bool private locked;

    constructor() {
        owner = msg.sender;
        taskCount = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this");
        _;
    }

    modifier nonReentrant() {
        require(!locked, "Reentrancy detected");
        locked = true;
        _;
        locked = false;
    }

    function addTask(string memory _description) public onlyOwner {
        tasks.push(Task(taskCount, _description, false));
        taskCount++;
    }

    function completeTask(uint _id) public nonReentrant {
        require(_id < taskCount, "Task does not exist");
        tasks[_id].completed = true;
    }

    function getTask(uint _id) public view returns (string memory, bool) {
        require(_id < taskCount, "Task does not exist");
        Task memory task = tasks[_id];
        return (task.description, task.completed);
    }
}