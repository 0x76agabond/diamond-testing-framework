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
import {IAdd4Facet} from "../../../src/interfaces/add/IAdd4Facet.sol";
import {Add4Facet} from "../../../src/facets/add/Add4Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd4Facet is tPrototype {
    Add4Facet public facet;

    function setUp() public override {
        facet = new Add4Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd4Facet.whoami4.selector;
        selectors[1] = IAdd4Facet.add4.selector;
        selectors[2] = IAdd4Facet.add4error.selector;
    }

    function buildCut() external override view returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}