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
import {IAdd12Facet} from "../../../src/interfaces/add/IAdd12Facet.sol";
import {Add12Facet} from "../../../src/facets/add/Add12Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd12Facet is tPrototype {
    Add12Facet public facet;

    function setUp() public override {
        facet = new Add12Facet();
        selectors = new bytes4[](3);
        selectors[0] = IAdd12Facet.whoami12.selector;
        selectors[1] = IAdd12Facet.add12.selector;
        selectors[2] = IAdd12Facet.add12error.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
