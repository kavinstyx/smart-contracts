// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Procurement {
    struct Bid {
        address supplier;
        uint256 amount;
        uint256 deliveryTime;
        bool selected;
    }
    
    struct ProcurementRequest {
        uint256 id;
        string description;
        address requester;
        uint256 deadline;
        bool fulfilled;
        Bid[] bids;
        address selectedSupplier;
    }
    
    mapping(uint256 => ProcurementRequest) public procurements;
    uint256 public nextProcurementId;
    
    event ProcurementCreated(uint256 indexed id, string description, address requester);
    
    function createProcurement(string memory description, uint256 deadline) public returns (uint256) {
        uint256 id = nextProcurementId++;
        
        procurements[id] = ProcurementRequest({
            id: id,
            description: description,
            requester: msg.sender,
            deadline: deadline,
            fulfilled: false,
            bids: new Bid[](0),
            selectedSupplier: address(0)
        });
        
        emit ProcurementCreated(id, description, msg.sender);
        return id;
    }
}