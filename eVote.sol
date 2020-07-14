pragma solidity ^0.6.11; // Uses a solc version greater than 0.6.11

contract eVotingSystem{
    address public admin;
    event LogAddCandidate(string name,string party, string symbol, address ad);
    event LogAddVoter(uint voterIDNumber, uint PIN);
    
    struct Candidate{
        string name;
        string party;
        string symbol;
    }
    struct Voter{
        uint voterIDNumber;
        uint PIN;
        bool hasVoted;
    }
    
    mapping(address => Candidate) private candidates;
    mapping(address => uint) private votes;
    mapping(address => Voter) private electRoll; 
    
    constructor () public {
        admin = msg.sender;
    }
    
    function vote(uint voterID, uint PIN, address candidate) public {
        require(electRoll[msg.sender].voterIDNumber == voterID);
        require(electRoll[msg.sender].PIN == PIN);
        require(electRoll[msg.sender].hasVoted == false);
        votes[candidate]++;
        electRoll[msg.sender].hasVoted = true;
    }
    
    function addVoter(uint voterID, uint PIN, address voter) public {
        require(msg.sender == admin); 
        Voter memory newVoter;
        newVoter.voterIDNumber = voterID;
        newVoter.PIN = PIN;
        newVoter.hasVoted = false;
        electRoll[voter] = newVoter;
        emit LogAddVoter(voterID,PIN);
    }
    
    function addCandidate(string memory name,string memory party,string memory symbol, address candidate) public {
        require(msg.sender == admin); 
        Candidate memory newCandidate;
        newCandidate.name = name;
        newCandidate.party = party;
        newCandidate.symbol = symbol;
        candidates[candidate] = newCandidate;
        votes[candidate] = 0;
        emit LogAddCandidate(name,party,symbol,candidate);
    }
    
}
