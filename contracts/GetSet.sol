// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./DataModel.sol";

contract GetSet is DataModel {

    event transferOwner(uint32 houseId);
    event tranferTenant(uint32 houseId);
    event paymentReceived(uint32 houseId, uint32 rent);
    
    function addOwner(string memory _oName, 
            string memory _phNum,
            address _oAddr) public returns (uint32){
        uint32 Id = owner_id++;
        owners[Id].ownerName= _oName;
        owners[Id].phoneNumber = _phNum;
        owners[Id].ownerAddress = _oAddr;
        return Id;
    }
    function getOwner(uint32 _OwnerId) public view returns (string memory, string memory, address) {
        return (owners[_OwnerId].ownerName,
                owners[_OwnerId].phoneNumber,
                owners[_OwnerId].ownerAddress);
    }

    function addTenant(
            string memory _tName, 
            string memory _bcId, 
            string memory _tphNum,
            address _tAddr) public returns (uint32){
        uint32 Id = tenant_id++;
        tenants[Id].tenantName= _tName;
        tenants[Id].bcId = _bcId;
        tenants[Id].phoneNumber = _tphNum;
        tenants[Id].tenantAddress = _tAddr;
        return Id;
    }
    function getTenant(uint32 _tenantId) public view returns (string memory,string memory, string memory, address) {
        return (tenants[_tenantId].tenantName,
                tenants[_tenantId].bcId,
                tenants[_tenantId].phoneNumber,
                tenants[_tenantId].tenantAddress);
    }

    
    function addHouse(uint32 _ownerId,
                      uint32 _tenantId,
                        string memory _houseNumber,
                        string memory _houseAddress,
                        uint32 _rent,
                        uint32 _tenancy) public returns (uint32) {
            uint32 Id = house_id++;
            houses[Id].houseNumber = _houseNumber;
            houses[Id].houseAddress = _houseAddress;
            houses[Id].ownerAddress = owners[_ownerId].ownerAddress;
            houses[Id].tenantId = _tenantId;
            houses[Id].rent = _rent;
            houses[Id].tenancy = _tenancy;
            houses[Id].startDate = uint32(block.timestamp);
            houses[Id].nextPaymentDate = houses[Id].startDate + 30 days;

            trackOwnedHouses[_ownerId].push(Id);
            trackHouseOwners[Id].push(_ownerId);
            trackHouseTenants[Id].push(_tenantId);
            return Id;
        }
    function getHouse(uint32 _houseId) public view returns (string memory,string memory,address,uint32,uint32, uint32, uint32, uint32){
        house memory h = houses[_houseId];
        return (h.houseNumber,
                h.houseAddress,
                h.ownerAddress,
                h.tenantId,
                h.rent,
                h.tenancy,
                h.startDate,
                h.nextPaymentDate);
    }
}