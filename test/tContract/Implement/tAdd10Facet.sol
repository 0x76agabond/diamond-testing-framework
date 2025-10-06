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
import {IAdd10Facet} from "../../../src/interfaces/add/IAdd10Facet.sol";
import {Add10Facet} from "../../../src/facets/add/Add10Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd10Facet is tPrototype {
    Add10Facet public facet;

    function setUp() public override {
        facet = new Add10Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd10Facet.whoami10.selector;
        selectors[1] = IAdd10Facet.add10.selector;
        selectors[2] = IAdd10Facet.add10error.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
