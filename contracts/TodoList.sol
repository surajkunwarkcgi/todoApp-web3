// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract Todolist {
    constructor() {
        ownerOfContract = msg.sender;
    }

    uint256 public _idUser;
    address public ownerOfContract;

    address[] public creators;
    string[] public message;
    uint256[] public messageId;

    struct TodoList {
        address account;
        uint256 userId;
        string message;
        bool completed;
    }

    event TodoEvent(
        address indexed account,
        uint256 indexed userId,
        string message,
        bool completed
    );

    mapping (address => TodoList) public todoListApps;

    function inc() internal {
        _idUser++;
    }

    function createList(string calldata _message) external {
        inc();

        uint256 idNumber = _idUser;
        TodoList storage toDo = todoListApps[msg.sender];

        toDo.account = msg.sender;
        toDo.message = _message;
        toDo.userId = idNumber;
        toDo.completed = false;

        creators.push(msg.sender);
        message.push(_message);
        messageId.push(idNumber);

        emit TodoEvent(msg.sender, toDo.userId, _message, toDo.completed);
    }

    function getCreatorData(address _address) public view returns (address, uint256, string memory, bool) {
        TodoList memory singleUserData = todoListApps[_address];

        return (
            singleUserData.account,
            singleUserData.userId,
            singleUserData.message,
            singleUserData.completed
        );
    }

    function getAddress() external view returns (address[] memory) {
        return creators;
    }

    function getMessage() external view returns (string[] memory) {
        return message;
    }

    function toggle(address _creator) public {
        TodoList storage singleUserData = todoListApps[_creator];
        singleUserData.completed = !singleUserData.completed;
    }
}