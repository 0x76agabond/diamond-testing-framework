// SPDX-License-Identifier: MIT
/******************************************************************************\
* Author: Hoang <ginz1504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import {IDiamondCut} from "../../../src/interfaces/IDiamondCut.sol";
import {IAdd6Facet} from "../../../src/interfaces/add/IAdd6Facet.sol";
import {Add6Facet} from "../../../src/facets/add/Add6Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd6Facet is tPrototype {
    Add6Facet public facet;

    function setUp() public override {
        facet = new Add6Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd6Facet.whoami6.selector;
        selectors[1] = IAdd6Facet.add6.selector;
        selectors[2] = IAdd6Facet.add6error.selector;
    }

    function buildCut() external override view returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}