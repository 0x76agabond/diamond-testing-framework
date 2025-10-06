// SPDX-License-Identifier: MIT
/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

pragma solidity ^0.8.26;

import {IDiamondCut} from "../../../src/interfaces/IDiamondCut.sol";
import {IAdd1Facet} from "../../../src/interfaces/add/IAdd1Facet.sol";
import {Add1Facet} from "../../../src/facets/add/Add1Facet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAdd1Facet is tPrototype {
    // for main call
    Add1Facet public facet;

    // set up here
    function setUp() public override {
        // Generate based on Facet
        facet = new Add1Facet();

        // Generate based on Interface
        selectors = new bytes4[](3);
        selectors[0] = IAdd1Facet.whoami1.selector;
        selectors[1] = IAdd1Facet.add1.selector;
        selectors[2] = IAdd1Facet.add1error.selector;
    }

    // basically same in all sub contract
    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
