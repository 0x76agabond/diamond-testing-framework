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
import {IAdd8Facet} from "../../../src/interfaces/add/IAdd8Facet.sol";
import {Add8Facet} from "../../../src/facets/add/Add8Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd8Facet is tPrototype {
    Add8Facet public facet;

    function setUp() public override {
        facet = new Add8Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd8Facet.whoami8.selector;
        selectors[1] = IAdd8Facet.add8.selector;
        selectors[2] = IAdd8Facet.add8error.selector;
    }

    function buildCut() external override view returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}