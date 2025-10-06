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
import {IAddFacet} from "../../../src/interfaces/add/IAddFacet.sol";
import {AddFacet} from "../../../src/facets/add/AddFacet.sol";
import {tPrototype} from "../tPrototype.sol";

contract tAddFacet is tPrototype {
    AddFacet public facet;

    function setUp() public override {
        facet = new AddFacet();

        selectors = new bytes4[](4);
        selectors[0] = IAddFacet.init.selector;
        selectors[1] = IAddFacet.addValue.selector;
        selectors[2] = IAddFacet.getValue.selector;
        selectors[3] = IAddFacet.adderror.selector;
    }

    function buildCut() external view override returns (IDiamondCut.FacetCut[] memory) {
        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
        cut[0] = IDiamondCut.FacetCut({
            facetAddress: address(facet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: selectors
        });
        return cut;
    }
}
