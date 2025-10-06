// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

import {tPrototype, IDiamondCut} from "../tPrototype.sol";

import {IDiamondLoupe} from "../../../src/interfaces/IDiamondLoupe.sol";
import {DiamondLoupeFacet} from "../../../src/facets/DiamondLoupeFacet.sol";

contract tDiamondLoupe is tPrototype {
    DiamondLoupeFacet public facet;

    function setUp() public override {
        // Generate based on Facet
        facet = new DiamondLoupeFacet();

        selectors = new bytes4[](4);
        selectors[0] = IDiamondLoupe.facets.selector;
        selectors[1] = IDiamondLoupe.facetFunctionSelectors.selector;
        selectors[2] = IDiamondLoupe.facetAddresses.selector;
        selectors[3] = IDiamondLoupe.facetAddress.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
