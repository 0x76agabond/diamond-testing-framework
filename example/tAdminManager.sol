pragma solidity ^0.8.19;

import {tPrototype, IDiamondCut, Enum} from "./tPrototype.sol";

import {IAdminManager} from "../../src/interfaces/IAdminManager.sol";
import {AdminManagerFacet} from "../../src/facets/AdminManagerFacet.sol";

contract tAdminManager is tPrototype {
    // for main call
    AdminManagerFacet public facet;    

    // set up here
    function setUp() public override  {
        // Generate based on Facet
        facet = new AdminManagerFacet();

        // Generate based on Interface
        selectors = new bytes4[](17);
        selectors[0] =  IAdminManager.isActive.selector;
        selectors[1] =  IAdminManager.isLocked.selector;
        selectors[2] =  IAdminManager.isSysAdmin.selector;
        selectors[3] =  IAdminManager.isTransAdmin.selector;
        selectors[4] =  IAdminManager.listSysAdmin.selector;
        selectors[5] =  IAdminManager.listTransAdmin.selector;
        selectors[6] =  IAdminManager.changeState.selector;
        selectors[7] =  IAdminManager.changeLockState.selector;
        selectors[8] =  IAdminManager.initAdmin.selector;
        selectors[9] =  IAdminManager.transferOwnership.selector;
        selectors[10] = IAdminManager.addSysAdmin.selector;
        selectors[11] = IAdminManager.removeSysAdmin.selector;
        selectors[12] = IAdminManager.addTransAdmin.selector;
        selectors[13] = IAdminManager.removeTransAdmin.selector;
        selectors[14] = IAdminManager.checkSignatureAccount.selector;
        selectors[15] = IAdminManager.checkSignatureAdmin.selector;
        selectors[16] = IAdminManager.CheckSignatureOwner.selector;
    }

    // basically same in all sub contract
    function buildCut() external  override view returns (IDiamondCut.FacetCut[] memory)
    {        
        return baseCut(address(facet));
    }    
}