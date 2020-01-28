pragma solidity ^0.5.12;

import './FreelanceToken.sol';

contract MarketPlace {
    
    mapping (address => bool) registeredAddresses;
    mapping (address => Manager) managers;
    mapping (address => Freelancer) freelancers;
    mapping (address => Evaluator) evaluators;

    mapping (uint => Task) public tasks;
    uint public tasksCount;
    
    address freelanceTokenAddress;
    FreelanceToken freelanceToken;
    address owner;
    
    struct Manager {
        string name;
        uint reputation;
    }
    
    struct Freelancer {
        string name;
        uint reputation;
        string categoryOfExpertise;
        uint tariffPerHour;
    }
    
    struct Evaluator {
        string name;
        uint reputation;
        string categoryOfExpertise;
        uint tariffPerHour;
    }
    
    struct Task {
        string description;
        uint freelancerReward;
        uint evaluatorReward;
        string categoryOfExpertise;
        uint freelancerTime;
        uint evaluatorTime;
        string manager;
    }
    
    constructor(address _freelanceTokenAddress) public {

        addTask("Description1", 100, 20, "Java", 1000, 300, "0x1b67fdE280cadA2B46E5300F1AdDbdf501e93A9c");
        addTask("Description2", 200, 30, ".NET", 2000, 500, "0x1b67fdE280cadA2B46E5300F1AdDbdf501e93A9c");

        freelanceTokenAddress = _freelanceTokenAddress;
        freelanceToken = FreelanceToken(freelanceTokenAddress);
        owner = msg.sender;    
    }

    function registerManager(address _managerAddress, string memory _name) public {
        require(registeredAddresses[_managerAddress] != true, 'Can not assign a new role to a registered address... ');
        managers[_managerAddress] = Manager(_name, 5);
        registeredAddresses[_managerAddress] = true;
        freelanceToken.transferFrom(owner, _managerAddress, 100);
    }
    
    function registerFreelancer(address _freelancerAddress, string memory _name, string memory _categoryOfExpertise, uint _tariffPerHour) public {
        require(registeredAddresses[_freelancerAddress] != true, 'Can not assign a new role to a registered address... ');
        freelancers[_freelancerAddress] = Freelancer(_name, 5, _categoryOfExpertise, _tariffPerHour);
        registeredAddresses[_freelancerAddress] = true;
        freelanceToken.transferFrom(owner, _freelancerAddress, 100);
    }
    
    function registerEvaluator(address _evaluatorAddress, string memory _name, string memory _categoryOfExpertise, uint _tariffPerHour) public {
        require(registeredAddresses[_evaluatorAddress] != true, 'Can not assign a new role to a registered address... ');
        evaluators[_evaluatorAddress] = Evaluator(_name, 5, _categoryOfExpertise, _tariffPerHour);
        registeredAddresses[_evaluatorAddress] = true;
        freelanceToken.transferFrom(owner, _evaluatorAddress, 100);
    }
    
    function getManagerName(address _managerAddress) public view returns(string memory) {
        return managers[_managerAddress].name;
    }

    function addTask(string memory _description, uint _freelancerReward, uint _evaluatorReward, 
                    string memory _categoryOfExpertise, uint _freelancerTime, uint _evaluatorTime, string memory _manager) private {
        tasksCount ++;
        tasks[tasksCount] = Task(_description, _freelancerReward, _evaluatorReward, _categoryOfExpertise, _freelancerTime, _evaluatorTime, _manager);
    }
 
}