const TaskManager = artifacts.require("TaskManager");
const { expectRevert } = require('@openzeppelin/test-helpers');
const { assert } = require("chai");

contract("TaskManager", (accounts) => {
    let taskManager;
    const owner = accounts[0];
    const nonOwner = accounts[1];

    beforeEach(async () => {
        taskManager = await TaskManager.new({ from: owner });
    });

    it("should add a task as owner", async () => {
        await taskManager.addTask("Learn Solidity", { from: owner });
        const task = await taskManager.getTask(0);
        assert.equal(task[0], "Learn Solidity", "Task description should match");
        assert.equal(task[1], false, "Task should not be completed");
        const count = await taskManager.taskCount();
        assert.equal(count.toString(), "1", "Task count should be 1");
    });

    it("should restrict addTask to owner", async () => {
        await expectRevert(
            taskManager.addTask("Unauthorized task", { from: nonOwner }),
            "Only the owner can call this"
        );
    });

    it("should complete a task", async () => {
        await taskManager.addTask("Finish project", { from: owner });
        await taskManager.completeTask(0, { from: nonOwner });
        const task = await taskManager.getTask(0);
        assert.equal(task[1], true, "Task should be completed");
    });
});