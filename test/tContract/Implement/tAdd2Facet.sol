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
import {IAdd2Facet} from "../../../src/interfaces/add/IAdd2Facet.sol";
import {Add2Facet} from "../../../src/facets/add/Add2Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd2Facet is tPrototype {
    Add2Facet public facet;

    function setUp() public override {
        facet = new Add2Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd2Facet.whoami2.selector;
        selectors[1] = IAdd2Facet.add2.selector;
        selectors[2] = IAdd2Facet.add2error.selector;
    }

    function buildCut() external override view returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}