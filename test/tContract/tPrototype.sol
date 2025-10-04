// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/******************************************************************************\
* Author: Hoang <ginz1504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import {IDiamondCut} from "../../src/interfaces/IDiamondCut.sol";
import "forge-std/Test.sol";

abstract contract tPrototype is Test {
    bytes4[] public selectors;

    // @notice Build facet cut struct based on selectors
    // @param facet The facet contract address
    // @return cut as An array containing one FacetCut with all selectors
    function setUp() public virtual;
    function buildCut() external view virtual returns (IDiamondCut.FacetCut[] memory);

    // basically same in all sub contract
    function baseCut(address facet) internal view returns (IDiamondCut.FacetCut[] memory)
    {        
        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
        cut[0] = IDiamondCut.FacetCut({
            facetAddress: facet,
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: selectors
        });

        return cut;
    }
}
