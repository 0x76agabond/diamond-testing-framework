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
import {IAdd17Facet} from "../../../src/interfaces/add/IAdd17Facet.sol";
import {Add17Facet} from "../../../src/facets/add/Add17Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd17Facet is tPrototype {
    Add17Facet public facet;

    function setUp() public override {
        facet = new Add17Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd17Facet.whoami17.selector;
        selectors[1] = IAdd17Facet.add17.selector;
        selectors[2] = IAdd17Facet.add17error.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
