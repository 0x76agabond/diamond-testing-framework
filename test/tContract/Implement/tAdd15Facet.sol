// SPDX-License-Identifier: MIT
/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import {IDiamondCut} from "../../../src/interfaces/IDiamondCut.sol";
import {IAdd15Facet} from "../../../src/interfaces/add/IAdd15Facet.sol";
import {Add15Facet} from "../../../src/facets/add/Add15Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd15Facet is tPrototype {
    Add15Facet public facet;

    function setUp() public override {
        facet = new Add15Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd15Facet.whoami15.selector;
        selectors[1] = IAdd15Facet.add15.selector;
        selectors[2] = IAdd15Facet.add15error.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
