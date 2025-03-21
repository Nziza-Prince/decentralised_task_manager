pragma solidity ^0.8.0;

contract TaskManager{
    struct Task{
        uint id;
        string description;
        bool completed;
    }

    Task[] public tasks;
    uint public taskCount;
    address public 

    constructor(){
        taskCount = 0;
    }

    function addTask(string memory _description) public {
        tasks.push(Task(taskCount,_description,false));
        taskCount++;
    }
    function completeTask(uint _id)public{
        require(_id < taskCount);
    }
}