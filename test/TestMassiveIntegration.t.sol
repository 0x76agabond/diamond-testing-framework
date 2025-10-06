// SPDX-License-Identifier: MIT
//test/TestMassiveIntegration.t.sol

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/


pragma solidity ^0.8.26;

import "forge-std/Test.sol";

import {IAdd1Facet} from "../src/interfaces/add/IAdd1Facet.sol";
import {IAdd2Facet} from "../src/interfaces/add/IAdd2Facet.sol";
import {IAdd3Facet} from "../src/interfaces/add/IAdd3Facet.sol";
import {IAdd4Facet} from "../src/interfaces/add/IAdd4Facet.sol";
import {IAdd5Facet} from "../src/interfaces/add/IAdd5Facet.sol";
import {IAdd6Facet} from "../src/interfaces/add/IAdd6Facet.sol";
import {IAdd7Facet} from "../src/interfaces/add/IAdd7Facet.sol";
import {IAdd8Facet} from "../src/interfaces/add/IAdd8Facet.sol";
import {IAdd9Facet} from "../src/interfaces/add/IAdd9Facet.sol";
import {IAdd10Facet} from "../src/interfaces/add/IAdd10Facet.sol";
import {IAdd11Facet} from "../src/interfaces/add/IAdd11Facet.sol";
import {IAdd12Facet} from "../src/interfaces/add/IAdd12Facet.sol";
import {IAdd13Facet} from "../src/interfaces/add/IAdd13Facet.sol";
import {IAdd14Facet} from "../src/interfaces/add/IAdd14Facet.sol";
import {IAdd15Facet} from "../src/interfaces/add/IAdd15Facet.sol";
import {IAdd16Facet} from "../src/interfaces/add/IAdd16Facet.sol";
import {IAdd17Facet} from "../src/interfaces/add/IAdd17Facet.sol";

import {Add1Facet} from "../src/facets/add/Add1Facet.sol";
import {Add2Facet} from "../src/facets/add/Add2Facet.sol";
import {Add3Facet} from "../src/facets/add/Add3Facet.sol";
import {Add4Facet} from "../src/facets/add/Add4Facet.sol";
import {Add5Facet} from "../src/facets/add/Add5Facet.sol";
import {Add6Facet} from "../src/facets/add/Add6Facet.sol";
import {Add7Facet} from "../src/facets/add/Add7Facet.sol";
import {Add8Facet} from "../src/facets/add/Add8Facet.sol";
import {Add9Facet} from "../src/facets/add/Add9Facet.sol";
import {Add10Facet} from "../src/facets/add/Add10Facet.sol";
import {Add11Facet} from "../src/facets/add/Add11Facet.sol";
import {Add12Facet} from "../src/facets/add/Add12Facet.sol";
import {Add13Facet} from "../src/facets/add/Add13Facet.sol";
import {Add14Facet} from "../src/facets/add/Add14Facet.sol";
import {Add15Facet} from "../src/facets/add/Add15Facet.sol";
import {Add16Facet} from "../src/facets/add/Add16Facet.sol";
import {Add17Facet} from "../src/facets/add/Add17Facet.sol";

import {DiamondCutFacet, IDiamondCut} from "../test/tContract/Implement/tDiamondCut.sol";
import {DiamondLoupeFacet, IDiamondLoupe} from "../test/tContract/Implement/tDiamondLoupe.sol";

import {Diamond} from "../src/Diamond.sol";

contract TestMassiveIntegration is Test {
    uint256 key_owner;
    Diamond diamond;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("opbnb"));
        key_owner = vm.envUint("CUSTOMER_KEY");
        diamondInit();
    }

    // Init facet
    // This use normal pattern to init diamond
    // This function demonstrates the Monolithic way to initialize a Diamond
    // for a test. It involves manually deploying and cutting each Facet one-by-one, resulting in a long, repetitive setup function.
    // TestInitDiamondWithDTO.t.sol
    function diamondInit() internal {
        vm.startPrank(vm.addr(key_owner));
        DiamondCutFacet cutFacet = new DiamondCutFacet();
        diamond = new Diamond(address(vm.addr(key_owner)), address(cutFacet));
        {
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
        }
        {
            Add1Facet add1 = new Add1Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd1Facet.whoami1.selector;
            selectors[1] = IAdd1Facet.add1.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add1),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add2Facet add2 = new Add2Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd2Facet.whoami2.selector;
            selectors[1] = IAdd2Facet.add2.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add2),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add3Facet add3 = new Add3Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd3Facet.whoami3.selector;
            selectors[1] = IAdd3Facet.add3.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add3),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add4Facet add4 = new Add4Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd4Facet.whoami4.selector;
            selectors[1] = IAdd4Facet.add4.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add4),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add5Facet add5 = new Add5Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd5Facet.whoami5.selector;
            selectors[1] = IAdd5Facet.add5.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add5),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add6Facet add6 = new Add6Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd6Facet.whoami6.selector;
            selectors[1] = IAdd6Facet.add6.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add6),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add7Facet add7 = new Add7Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd7Facet.whoami7.selector;
            selectors[1] = IAdd7Facet.add7.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add7),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add8Facet add8 = new Add8Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd8Facet.whoami8.selector;
            selectors[1] = IAdd8Facet.add8.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add8),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add9Facet add9 = new Add9Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd9Facet.whoami9.selector;
            selectors[1] = IAdd9Facet.add9.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add9),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add10Facet add10 = new Add10Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd10Facet.whoami10.selector;
            selectors[1] = IAdd10Facet.add10.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add10),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add11Facet add11 = new Add11Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd11Facet.whoami11.selector;
            selectors[1] = IAdd11Facet.add11.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add11),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add12Facet add12 = new Add12Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd12Facet.whoami12.selector;
            selectors[1] = IAdd12Facet.add12.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add12),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add13Facet add13 = new Add13Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd13Facet.whoami13.selector;
            selectors[1] = IAdd13Facet.add13.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add13),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add14Facet add14 = new Add14Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd14Facet.whoami14.selector;
            selectors[1] = IAdd14Facet.add14.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add14),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add15Facet add15 = new Add15Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd15Facet.whoami15.selector;
            selectors[1] = IAdd15Facet.add15.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add15),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add16Facet add16 = new Add16Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd16Facet.whoami16.selector;
            selectors[1] = IAdd16Facet.add16.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add16),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            Add17Facet add17 = new Add17Facet();
            bytes4[] memory selectors = new bytes4[](2);
            selectors[0] = IAdd17Facet.whoami17.selector;
            selectors[1] = IAdd17Facet.add17.selector;

            IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
            cut[0] = IDiamondCut.FacetCut({
                facetAddress: address(add17),
                action: IDiamondCut.FacetCutAction.Add,
                functionSelectors: selectors
            });

            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
    }

    // Test integration with multiple facet
    // This function serves not only as a test but also as a live implementation environment.
    // Other solution like struct / split function but those method will break the state
    // For complicated functions, you can code directly here to see live results and debug.
    function test_massive_integration() public {
        {
            console.log(" ================================== ");
            address[] memory facets = IDiamondLoupe(address(diamond)).facetAddresses();
            for (uint256 i = 0; i < facets.length; i++) {
                console.log(address(facets[i]));
            }
        }
        {
            console.log(IAdd17Facet(address(diamond)).whoami17());
        }

        uint256 summer = 0;

        // use Scope {}
        {
            summer = IAdd1Facet(address(diamond)).add1(summer);
            console.log(summer);
            assertEq(summer, 1, "Summer should be 1 after add1");
        }
        {
            summer = IAdd2Facet(address(diamond)).add2(summer);
            console.log(summer);
            assertEq(summer, 3, "Summer should be 3 after add2");
        }
        {
            summer = IAdd3Facet(address(diamond)).add3(summer);
            console.log(summer);
            assertEq(summer, 6, "Summer should be 6 after add3");
        }
        {
            summer = IAdd4Facet(address(diamond)).add4(summer);
            console.log(summer);
            assertEq(summer, 10, "Summer should be 10 after add4");
        }
        {
            summer = IAdd5Facet(address(diamond)).add5(summer);
            console.log(summer);
            assertEq(summer, 15, "Summer should be 15 after add5");
        }
        {
            summer = IAdd6Facet(address(diamond)).add6(summer);
            console.log(summer);
            assertEq(summer, 21, "Summer should be 21 after add6");
        }
        {
            summer = IAdd7Facet(address(diamond)).add7(summer);
            console.log(summer);
            assertEq(summer, 28, "Summer should be 28 after add7");
        }
        {
            summer = IAdd8Facet(address(diamond)).add8(summer);
            console.log(summer);
            assertEq(summer, 36, "Summer should be 36 after add8");
        }
        {
            summer = IAdd9Facet(address(diamond)).add9(summer);
            console.log(summer);
            assertEq(summer, 45, "Summer should be 45 after add9");
        }

        // use Try / Catch pattern
        {
            try IAdd10Facet(address(diamond)).add10(summer) returns (uint256 newSummer) {
                summer = newSummer;
                console.log(summer);
            } catch {
                console.log("Error calling add10");
            }
        }
        {
            try IAdd11Facet(address(diamond)).add11(summer) returns (uint256 newSummer) {
                summer = newSummer;
                console.log(summer);
            } catch {
                console.log("Error calling add11");
            }
        }
        {
            try IAdd12Facet(address(diamond)).add12(summer) returns (uint256 newSummer) {
                summer = newSummer;
                console.log(summer);
            } catch {
                console.log("Error calling add12");
            }
        }
        {
            try IAdd13Facet(address(diamond)).add13(summer) returns (uint256 newSummer) {
                summer = newSummer;
                console.log(summer);
            } catch {
                console.log("Error calling add13");
            }
        }
        {
            try IAdd14Facet(address(diamond)).add14(summer) returns (uint256 newSummer) {
                summer = newSummer;
                console.log(summer);
            } catch {
                console.log("Error calling add14");
            }
        }
        {
            try IAdd15Facet(address(diamond)).add15(summer) returns (uint256 newSummer) {
                summer = newSummer;
                console.log(summer);
            } catch {
                console.log("Error calling add15");
            }
        }
        {
            try IAdd16Facet(address(diamond)).add16(summer) returns (uint256 newSummer) {
                summer = newSummer;
                console.log(summer);
            } catch {
                console.log("Error calling add16");
            }
        }
        {
            try IAdd17Facet(address(diamond)).add17(summer) returns (uint256 newSummer) {
                summer = newSummer;
                console.log(summer);
            } catch {
                console.log("Error calling add17");
            }
        }

        // handle Failpath
        {
            try IAdd1Facet(address(diamond)).add1error() {
                console.log("add1error did not revert");
            } catch {
                console.log("add1error reverted as expected");
            }
        }
        {
            try IAdd2Facet(address(diamond)).add2error() {
                console.log("add2error did not revert");
            } catch {
                console.log("add2error reverted as expected");
            }
        }
        {
            try IAdd3Facet(address(diamond)).add3error() {
                console.log("add3error did not revert");
            } catch {
                console.log("add3error reverted as expected");
            }
        }
        {
            try IAdd4Facet(address(diamond)).add4error() {
                console.log("add4error did not revert");
            } catch {
                console.log("add4error reverted as expected");
            }
        }
        {
            try IAdd5Facet(address(diamond)).add5error() {
                console.log("add5error did not revert");
            } catch {
                console.log("add5error reverted as expected");
            }
        }
        {
            try IAdd6Facet(address(diamond)).add6error() {
                console.log("add6error did not revert");
            } catch {
                console.log("add6error reverted as expected");
            }
        }
        {
            try IAdd7Facet(address(diamond)).add7error() {
                console.log("add7error did not revert");
            } catch {
                console.log("add7error reverted as expected");
            }
        }
        {
            try IAdd8Facet(address(diamond)).add8error() {
                console.log("add8error did not revert");
            } catch {
                console.log("add8error reverted as expected");
            }
        }
        {
            try IAdd9Facet(address(diamond)).add9error() {
                console.log("add9error did not revert");
            } catch {
                console.log("add9error reverted as expected");
            }
        }
        {
            try IAdd10Facet(address(diamond)).add10error() {
                console.log("add10error did not revert");
            } catch {
                console.log("add10error reverted as expected");
            }
        }
        {
            try IAdd11Facet(address(diamond)).add11error() {
                console.log("add11error did not revert");
            } catch {
                console.log("add11error reverted as expected");
            }
        }
        {
            try IAdd12Facet(address(diamond)).add12error() {
                console.log("add12error did not revert");
            } catch {
                console.log("add12error reverted as expected");
            }
        }
        {
            try IAdd13Facet(address(diamond)).add13error() {
                console.log("add13error did not revert");
            } catch {
                console.log("add13error reverted as expected");
            }
        }
        {
            try IAdd14Facet(address(diamond)).add14error() {
                console.log("add14error did not revert");
            } catch {
                console.log("add14error reverted as expected");
            }
        }
        {
            try IAdd15Facet(address(diamond)).add15error() {
                console.log("add15error did not revert");
            } catch {
                console.log("add15error reverted as expected");
            }
        }
        {
            try IAdd16Facet(address(diamond)).add16error() {
                console.log("add16error did not revert");
            } catch {
                console.log("add16error reverted as expected");
            }
        }
        {
            try IAdd17Facet(address(diamond)).add17error() {
                console.log("add17error did not revert");
            } catch {
                console.log("add17error reverted as expected");
            }
        }
    }
}
