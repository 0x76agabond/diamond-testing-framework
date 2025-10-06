// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

import {tPrototype, IDiamondCut} from "../tPrototype.sol";

import {DiamondCutFacet} from "../../../src/facets/DiamondCutFacet.sol";

contract tDiamondCut is tPrototype {
    DiamondCutFacet public facet;

    function setUp() public override {
        // Generate based on Facet
        facet = new DiamondCutFacet();

        selectors = new bytes4[](1);
        selectors[0] = IDiamondCut.diamondCut.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
