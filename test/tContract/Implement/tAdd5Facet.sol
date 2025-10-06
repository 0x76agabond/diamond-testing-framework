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
import {IAdd5Facet} from "../../../src/interfaces/add/IAdd5Facet.sol";
import {Add5Facet} from "../../../src/facets/add/Add5Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd5Facet is tPrototype {
    Add5Facet public facet;

    function setUp() public override {
        facet = new Add5Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd5Facet.whoami5.selector;
        selectors[1] = IAdd5Facet.add5.selector;
        selectors[2] = IAdd5Facet.add5error.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
