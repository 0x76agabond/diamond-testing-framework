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
import {IAdd11Facet} from "../../../src/interfaces/add/IAdd11Facet.sol";
import {Add11Facet} from "../../../src/facets/add/Add11Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd11Facet is tPrototype {
    Add11Facet public facet;

    function setUp() public override {
        facet = new Add11Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd11Facet.whoami11.selector;
        selectors[1] = IAdd11Facet.add11.selector;
        selectors[2] = IAdd11Facet.add11error.selector;
    }

    function buildCut() external override view returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}