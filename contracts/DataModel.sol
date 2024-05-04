// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DataModel {
    uint32 public tenant_id = 1;   
    uint32 public owner_id = 0;  
    uint32 public house_id = 0;
    address admin = msg.sender;

    struct house {
        string houseNumber;
        string houseAddress;
        address ownerAddress;
        uint32 tenantId;
        uint32 rent;
        uint32 tenancy; //in months
        uint32 startDate;
        uint32 nextPaymentDate;
    }
    mapping(uint32 => house) public houses;

    struct tenant {
        string tenantName;
        string bcId;
        string phoneNumber;
        address tenantAddress;
    }
    mapping(uint32 => tenant) public tenants;

    struct owner {
        string ownerName;
        string phoneNumber;
        address ownerAddress;
    }
    mapping(uint32 => owner) public owners;
    
    mapping(uint32 => uint32[]) public trackHouseTenants;  
    mapping(uint32 => uint32[]) public trackHouseOwners;

    mapping(uint32 => uint32[]) public trackOwnedHouses;
}