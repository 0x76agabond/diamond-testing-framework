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
import {IAdd7Facet} from "../../../src/interfaces/add/IAdd7Facet.sol";
import {Add7Facet} from "../../../src/facets/add/Add7Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd7Facet is tPrototype {
    Add7Facet public facet;

    function setUp() public override {
        facet = new Add7Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd7Facet.whoami7.selector;
        selectors[1] = IAdd7Facet.add7.selector;
        selectors[2] = IAdd7Facet.add7error.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
