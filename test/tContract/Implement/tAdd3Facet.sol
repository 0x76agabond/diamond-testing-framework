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
import {IAdd3Facet} from "../../../src/interfaces/add/IAdd3Facet.sol";
import {Add3Facet} from "../../../src/facets/add/Add3Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd3Facet is tPrototype {
    Add3Facet public facet;

    function setUp() public override {
        facet = new Add3Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd3Facet.whoami3.selector;
        selectors[1] = IAdd3Facet.add3.selector;
        selectors[2] = IAdd3Facet.add3error.selector;
    }

    function buildCut() external override view returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}