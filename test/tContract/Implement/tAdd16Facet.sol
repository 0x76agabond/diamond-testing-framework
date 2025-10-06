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
import {IAdd16Facet} from "../../../src/interfaces/add/IAdd16Facet.sol";
import {Add16Facet} from "../../../src/facets/add/Add16Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd16Facet is tPrototype {
    Add16Facet public facet;

    function setUp() public override {
        facet = new Add16Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd16Facet.whoami16.selector;
        selectors[1] = IAdd16Facet.add16.selector;
        selectors[2] = IAdd16Facet.add16error.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
