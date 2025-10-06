// SPDX-License-Identifier: MIT
//test/TestAddFacet.t.sol

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/


pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import {AddFacet} from "../src/facets/add/AddFacet.sol";
import {IAddFacet} from "../src/interfaces/add/IAddFacet.sol";
import {Diamond} from "../src/Diamond.sol";
import {DiamondCutFacet} from "../src/facets/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "../src/facets/DiamondLoupeFacet.sol";
import {IDiamondCut} from "../src/interfaces/IDiamondCut.sol";
import {IDiamondLoupe} from "../src/interfaces/IDiamondLoupe.sol";

contract TestAddFacet is Test {
    AddFacet addFacetImpl;
    IAddFacet addFacet;

    function setUp() public {
        addFacetImpl = new AddFacet();
        addFacet = IAddFacet(address(addFacetImpl));
    }

    // This test verifies the initialization and retrieval of the AddFacet's value.
    function test_InitAndGetValue() public {
        uint256 initialValue = 123;
        addFacetImpl.init(initialValue);
        assertEq(addFacet.getValue(), initialValue, "Initial value should be set correctly");
    }

    // This test checks the addValue function's behavior and ensures state immutability.
    function test_AddValue() public {
        uint256 initialValue = 10;
        addFacetImpl.init(initialValue);
        uint256 result = addFacet.addValue(5);
        assertEq(result, 15, "addValue should return initialValue + added value");
        assertEq(addFacet.getValue(), initialValue, "getValue should remain initialValue");
    }

    // This test verifies that the adderror function correctly reverts.
    function test_AddError() public {
        try addFacet.adderror() {
            fail("adderror did not revert");
        } catch {
            // Expected revert
        }
    }

    // This test demonstrates integrating AddFacet into a Diamond and interacting with it.
    // It follows a normal test pattern for Diamond-based contracts.
    function test_DiamondAddFacet() public {
        vm.startPrank(address(this)); // Use the test contract as the owner

        // Deploy DiamondCutFacet and Diamond
        DiamondCutFacet cutFacet = new DiamondCutFacet();
        Diamond diamond = new Diamond(address(this), address(cutFacet));

        // Cut in DiamondLoupeFacet

        DiamondLoupeFacet loupe = new DiamondLoupeFacet();
        bytes4[] memory selectors = new bytes4[](4);
        selectors[0] = IDiamondLoupe.facets.selector;
        selectors[1] = IDiamondLoupe.facetFunctionSelectors.selector;
        selectors[2] = IDiamondLoupe.facetAddresses.selector;
        selectors[3] = IDiamondLoupe.facetAddress.selector;

        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
        cut[0] = IDiamondCut.FacetCut({
            facetAddress: address(loupe),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: selectors
        });

        IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");

        // Cut in AddFacet

        uint256 initialValue = 200;
        AddFacet addFacetImplDiamond = new AddFacet();
        selectors = new bytes4[](3);
        selectors[0] = IAddFacet.addValue.selector;
        selectors[1] = IAddFacet.getValue.selector;
        selectors[2] = IAddFacet.adderror.selector;

        cut = new IDiamondCut.FacetCut[](1);
        cut[0] = IDiamondCut.FacetCut({
            facetAddress: address(addFacetImplDiamond),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: selectors
        });

        IDiamondCut(address(diamond)).diamondCut(
            cut, address(addFacetImplDiamond), abi.encodeWithSelector(IAddFacet.init.selector, initialValue)
        );

        // Interact with AddFacet through Diamond
        IAddFacet addFacetDiamond = IAddFacet(address(diamond));
        assertEq(addFacetDiamond.getValue(), 200, "Initial value from Diamond AddFacet should be 200");
        uint256 result = addFacetDiamond.addValue(75);
        assertEq(result, 275, "addValue through Diamond should return initialValue + added value");

        // Test adderror through Diamond
        vm.expectRevert();
        addFacetDiamond.adderror();
    }
}
