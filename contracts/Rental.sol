// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./DataModel.sol";
import "./GetSet.sol";

contract Rental is DataModel, GetSet{
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "You are not the admin");
         _;
    }
    modifier onlyOwner(uint32 _houseId) {
         require(msg.sender == houses[_houseId].ownerAddress, "You are not the owner");
         _;
    }
    modifier onlyTenant(uint32 _houseId, uint32 _tenantId) {
         require(_tenantId == houses[_houseId].tenantId, "You are not the tenant");
         _;
    }
    modifier isRented(uint32 _houseId) {
        require(houses[_houseId].tenantId != 0, "No tenant");
        _;
    }
   

    function deleteHouse(uint32 _ownerId, uint32 _houseId) internal returns(uint32 ) {
        uint32[] memory houses = trackOwnedHouses[_ownerId];
        uint256 l = houses.length;
        uint256 index = 0;
        for (uint256 i = 0; i < l; i++) {
            if (houses[i] == _houseId) {
                index = i;
                for (uint256 j = i+1; j < l; j++) {
                    trackOwnedHouses[_ownerId][j-1] = trackOwnedHouses[_ownerId][j];
                }
                trackOwnedHouses[_ownerId].pop();
                break;
            }
        }
        return 0;
    }

    //Transfer 
    function newOwner(uint32 _oldOwnerId, uint32 _newOwnerId, uint32 _houseId) onlyOwner(_houseId) public returns (uint32) {
        deleteHouse(_oldOwnerId, _houseId);
        owner memory o2 = owners[_newOwnerId]; 
        houses[_houseId].ownerAddress = o2.ownerAddress;
        houses[_houseId].tenantId = 0;
        houses[_houseId].rent = 0;
        houses[_houseId].tenancy = 0; 

        trackOwnedHouses[_newOwnerId].push(_houseId);
        trackHouseOwners[_houseId].push(_newOwnerId);
        trackHouseTenants[_houseId].push(0);
        emit transferOwner(_houseId);
        return _newOwnerId;
    }

    function newTenant(uint32 _houseId, uint32 _newTenantId, uint32 _rent, uint32 _tenancy) onlyOwner(_houseId) public returns (uint32) {
        houses[_houseId].tenantId = _newTenantId;
        houses[_houseId].rent = _rent;
        houses[_houseId].tenancy = _tenancy;
        houses[_houseId].startDate = uint32(block.timestamp);

        trackHouseTenants[_houseId].push(_newTenantId);
        emit tranferTenant(_houseId);
        return _newTenantId;
    }

    //View
    function viewTenantDetails(uint32 _houseId) isRented(_houseId) onlyOwner(_houseId) public view returns(uint32, string memory, string memory, string memory, address) {
        uint32 Id = houses[_houseId].tenantId;
        return (Id, 
        tenants[Id].tenantName, 
        tenants[Id].bcId,
        tenants[Id].phoneNumber,
        tenants[Id].tenantAddress);
    }

    //Modify
    function modifyTenant(uint32 _houseId, uint32 _rent, uint32 _tenancy) isRented(_houseId) onlyOwner(_houseId) public returns(uint32) {
        houses[_houseId].rent = _rent;
        houses[_houseId].tenancy += _tenancy;
        return houses[_houseId].tenantId;
    }

    //PayRent
    function payRent(uint32 _houseId,uint32 _tenantId, uint32 _rent) isRented(_houseId) onlyTenant(_houseId, _tenantId) public returns (bool) {
        require(_rent == houses[_houseId].rent, "Incorrect payment amount");
        require(block.timestamp <= houses[_houseId].nextPaymentDate, "Rent is already paid for the current month");
        houses[_houseId].nextPaymentDate += 30 days;
        emit paymentReceived(_houseId, _rent);
        return true;
    }

    //Check rent due
    function checkRentDue(uint32 _houseId) isRented(_houseId) onlyOwner(_houseId) public view returns(bool) {
        return block.timestamp >= houses[_houseId].nextPaymentDate;
    }
 
    //Tracking
    function OwnedHouses(uint32 _ownerId) onlyAdmin() public view returns(uint32[] memory) {
        return trackOwnedHouses[_ownerId];
    }
    function houseOwners(uint32 _houseId) onlyAdmin() public view returns (uint32[] memory) {
       return trackHouseOwners[_houseId];
    }
    function houseTenants(uint32 _houseId) onlyAdmin() public view returns (uint32[] memory) {
       return trackHouseTenants[_houseId];
    }
}
