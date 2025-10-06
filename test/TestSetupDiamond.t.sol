// SPDX-License-Identifier: MIT
//test/TestSetupDiamond.t.sol

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/


pragma solidity ^0.8.26;

import "forge-std/Test.sol";

import {Diamond, CutUtil} from "../test/tContract/tPrototype.sol";

import {DiamondCutFacet} from "../src/facets/DiamondCutFacet.sol";
import {IDiamondLoupe, tDiamondLoupe} from "../test/tContract/Implement/tDiamondLoupe.sol";

import {IAddFacet, tAddFacet} from "../test/tContract/Implement/tAddFacet.sol";
import {IAdd1Facet, tAdd1Facet} from "../test/tContract/Implement/tAdd1Facet.sol";
import {IAdd2Facet, tAdd2Facet} from "../test/tContract/Implement/tAdd2Facet.sol";
import {IAdd3Facet, tAdd3Facet} from "../test/tContract/Implement/tAdd3Facet.sol";
import {IAdd4Facet, tAdd4Facet} from "../test/tContract/Implement/tAdd4Facet.sol";
import {IAdd5Facet, tAdd5Facet} from "../test/tContract/Implement/tAdd5Facet.sol";
import {IAdd6Facet, tAdd6Facet} from "../test/tContract/Implement/tAdd6Facet.sol";
import {IAdd7Facet, tAdd7Facet} from "../test/tContract/Implement/tAdd7Facet.sol";
import {IAdd8Facet, tAdd8Facet} from "../test/tContract/Implement/tAdd8Facet.sol";
import {IAdd9Facet, tAdd9Facet} from "../test/tContract/Implement/tAdd9Facet.sol";
import {IAdd10Facet, tAdd10Facet} from "../test/tContract/Implement/tAdd10Facet.sol";
import {IAdd11Facet, tAdd11Facet} from "../test/tContract/Implement/tAdd11Facet.sol";
import {IAdd12Facet, tAdd12Facet} from "../test/tContract/Implement/tAdd12Facet.sol";
import {IAdd13Facet, tAdd13Facet} from "../test/tContract/Implement/tAdd13Facet.sol";
import {IAdd14Facet, tAdd14Facet} from "../test/tContract/Implement/tAdd14Facet.sol";
import {IAdd15Facet, tAdd15Facet} from "../test/tContract/Implement/tAdd15Facet.sol";
import {IAdd16Facet, tAdd16Facet} from "../test/tContract/Implement/tAdd16Facet.sol";
import {IAdd17Facet, tAdd17Facet} from "../test/tContract/Implement/tAdd17Facet.sol";

import {Diamond} from "../src/Diamond.sol";

contract TestSetupDiamond is Test {
    uint256 key_owner;
    Diamond diamond;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("opbnb"));
        key_owner = uint256(keccak256(abi.encodePacked("demo key", block.timestamp)));
        address user = vm.addr(key_owner);
        vm.deal(user, 10 ether);
        vm.label(user, "demo-user");
        setupDiamond();
    }

    function setupDiamond() internal {
        vm.startPrank(vm.addr(key_owner));

        // Deploy DiamondCutFacet and the main Diamond contract
        {
            DiamondCutFacet cutFacet = new DiamondCutFacet();
            diamond = new Diamond(address(vm.addr(key_owner)), address(cutFacet));
        }

        // start setup here
        {
            console.log(" ================================== ");
            console.log(" setupDiamond ");
            console.log(" ================================== ");

            // Base utility facets
            console.log(CutUtil.cutHelper(diamond, new tDiamondLoupe(), ""));

            // Functional modules
            console.log(CutUtil.cutHelper(diamond, new tAdd1Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd2Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd3Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd4Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd5Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd6Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd7Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd8Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd9Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd10Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd11Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd12Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd13Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd14Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd15Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd16Facet(), ""));
            console.log(CutUtil.cutHelper(diamond, new tAdd17Facet(), ""));

            // Initialization facet (with parameters)
            console.log(
                CutUtil.cutHelper(diamond, new tAddFacet(), abi.encodeWithSelector(IAddFacet.init.selector, 500))
            );
        }

        vm.stopPrank();
    }

    // Test integration with multiple facet
    // This function serves not only as a test but also as a live implementation environment.
    // There are other solution like struct / split function but those method will break the state
    // For complicated functions, you can code directly here to see live results and debug.
    function test_massive_integration() public {
        {
            console.log(" ================================== ");
            console.log(" IDiamondLoupe ");
            console.log(" ================================== ");
            address[] memory facets = IDiamondLoupe(address(diamond)).facetAddresses();
            for (uint256 i = 0; i < facets.length; i++) {
                console.log(address(facets[i]));
            }
        }
        {
            console.log(" ================================== ");
            console.log(" IAdd17Facet(address(diamond)).whoami17() ");
            console.log(" ================================== ");
            console.log(IAdd17Facet(address(diamond)).whoami17());
        }

        uint256 summer = 0;

        console.log(" ================================== ");
        console.log(" test_massive_integration ");
        console.log(" use Scope {} ");
        console.log(" ================================== ");

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

        console.log(" ================================== ");
        console.log(" test_massive_integration ");
        console.log(" use Try / Catch pattern ");
        console.log(" ================================== ");
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
        console.log(" ================================== ");
        console.log(" test_massive_integration ");
        console.log(" use Try / Catch pattern - Failpath ");
        console.log(" ================================== ");
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
