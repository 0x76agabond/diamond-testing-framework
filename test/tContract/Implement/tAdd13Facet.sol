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
import {IAdd13Facet} from "../../../src/interfaces/add/IAdd13Facet.sol";
import {Add13Facet} from "../../../src/facets/add/Add13Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd13Facet is tPrototype {
    Add13Facet public facet;

    function setUp() public override {
        facet = new Add13Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd13Facet.whoami13.selector;
        selectors[1] = IAdd13Facet.add13.selector;
        selectors[2] = IAdd13Facet.add13error.selector;
    }

    function buildCut() external override view returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}