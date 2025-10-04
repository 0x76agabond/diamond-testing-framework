// SPDX-License-Identifier: LicenseRef-Proprietary
/* 
   Proprietary License

   © 2025 [Jilnesta]. All rights reserved.

   This contract is proprietary software. It may only be used, copied, modified, or distributed 
   by [Jilnesta], or with written permission from [Jilnesta].

   Unauthorized use is strictly prohibited.

   Author [Hoang]*/

pragma solidity >=0.8.0 <0.9.0;

import "openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol";
import { LibDiamond } from  "../libraries/LibDiamond.sol";
import {LibFVSFAdmin} from "../libraries/LibFVSFAdmin.sol";
import {LibFVSF} from "../libraries/LibFVSF.sol";
import {Enum} from "../libraries/Enum.sol";
import {BaseFacet} from "../base/BaseFacet.sol";
import {BaseSignatureFacet} from "../base/BaseSignatureFacet.sol";


contract AdminManagerFacet is BaseFacet, BaseSignatureFacet
{
    using EnumerableSet for EnumerableSet.AddressSet;

    // ===================================================================
    // Event     
    // ===================================================================

    event StateChanged(bool isActive);
    event LockStateChanged(bool isLocked);
    event SysAdminAdded(address indexed admin);
    event SysAdminRemoved(address indexed admin);
    event TransAdminAdded(address indexed admin);
    event TransAdminRemoved(address indexed admin);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // ===================================================================
    //               GETTER
    // ===================================================================
    
    function isActive() external view returns (bool) {
        return LibFVSFAdmin.get().isActive;
    }

    function isLocked() external view returns (bool) {
        return LibFVSFAdmin.get().isLocked;
    }

    function isSysAdmin(address user) external view returns (bool) {
        return LibFVSFAdmin.get().sys_admins[user];
    }

    function isTransAdmin(address user) external view returns (bool) {
        return LibFVSFAdmin.get().trans_admins[user];
    }

    // ===================================================================
    //              SETTER
    // ===================================================================    

    function changeState() external onlyOwner nonReentrant
    {
        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();
        s.isActive = !s.isActive;
        emit StateChanged(s.isActive);
    } 

    function changeLockState() external onlyOwner nonReentrant
    {
        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();
        s.isLocked = !s.isLocked;
        emit LockStateChanged(s.isLocked);
    } 

    // ===================================================================  
    // Init
    // ===================================================================    

    // add boss as both System Admin and Transaction Admin
    function initAdmin() onlyOwner external {

        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();
        require(!s.initialized, "Already initialized");

        s.sys_admins[msg.sender] = true;
        s.trans_admins[msg.sender] = true;
        s.arr_sys_admins.add(msg.sender);
        s.arr_trans_admins.add(msg.sender);

        s.initialized = true;
    }

    function transferOwnership(address newOwner) onlyOwner external {

        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();

        require(newOwner != address(0), "Invalid owner");
        require(!s.sys_admins[newOwner], "Address is already an admin");
        require(!s.trans_admins[newOwner], "Address is already an admin");

        s.sys_admins[newOwner] = true;
        s.trans_admins[newOwner] = true;
        s.arr_sys_admins.add(newOwner);
        s.arr_trans_admins.add(newOwner);

        LibDiamond.setContractOwner(newOwner);
        emit OwnershipTransferred(msg.sender, newOwner);
    }

    // ===================================================================
    //         SYSTEM ADMIN MANAGEMENT
    // ===================================================================

    function addSysAdmin(address admin) external onlyOwner nonReentrant {
        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();
        require(!s.sys_admins[admin], "Already sys admin");
        s.sys_admins[admin] = true;
        s.arr_sys_admins.add(admin);
        emit SysAdminAdded(admin);
    }

    function removeSysAdmin(address admin) external onlyOwner nonReentrant {
        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();
        require(s.sys_admins[admin], "Not sys admin");
        require(admin != LibDiamond.contractOwner(), "Can't remove boss");
        s.sys_admins[admin] = false;
        s.arr_sys_admins.remove(admin);
        emit SysAdminRemoved(admin);
    }

    // ===================================================================
    //         TRANSACTION ADMIN MANAGEMENT
    // ===================================================================

    function addTransAdmin(address admin) external mSysAdmin nonReentrant {
        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();
        require(!s.trans_admins[admin], "Already trans admin");
        s.trans_admins[admin] = true;
        s.arr_trans_admins.add(admin);
        emit TransAdminAdded(admin);
    }

    function removeTransAdmin(address admin) external mSysAdmin nonReentrant {
        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();
        require(s.trans_admins[admin], "Not trans admin");
        require(admin != LibDiamond.contractOwner(), "Can't remove boss");
        s.trans_admins[admin] = false;
        s.arr_trans_admins.remove(admin);
        emit TransAdminRemoved(admin);
    }

    // ===================================================================
    //              ADMIN LISTING
    // ===================================================================

    function listSysAdmin() external view returns (address[] memory) {
        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();
        uint256 len = s.arr_sys_admins.length();
        address[] memory result = new address[](len);
        for (uint256 i; i < len; i++) {
            result[i] = s.arr_sys_admins.at(i);
        }
        return result;
    }

    function listTransAdmin() external view returns (address[] memory) {
        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();
        uint256 len = s.arr_trans_admins.length();
        address[] memory result = new address[](len);
        for (uint256 i; i < len; i++) {
            result[i] = s.arr_trans_admins.at(i);
        }
        return result;
    }    

    // ===================================================================
    //              Signatures Verify
    // ===================================================================

    function checkSignatureAccount(bytes32 txHash,bytes memory signatures, address target) external pure returns (bool) 
    {
       return baseCheckSignatureAccount(txHash, signatures, target); 
    }

    function checkSignatureAdmin(Enum.Admin ctype,bytes32 txHash,bytes memory signatures)  external view     returns (bool) 
    {
       return baseCheckSignatureAdmin(ctype, txHash, signatures); 
    }

    function CheckSignatureOwner(bytes32 txHash,bytes memory signatures) external view returns (bool) 
    {            
        return baseCheckSignatureOwner(txHash, signatures);
    }
}