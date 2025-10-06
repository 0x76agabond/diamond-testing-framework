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
import {IAdd9Facet} from "../../../src/interfaces/add/IAdd9Facet.sol";
import {Add9Facet} from "../../../src/facets/add/Add9Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd9Facet is tPrototype {
    Add9Facet public facet;

    function setUp() public override {
        facet = new Add9Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd9Facet.whoami9.selector;
        selectors[1] = IAdd9Facet.add9.selector;
        selectors[2] = IAdd9Facet.add9error.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
