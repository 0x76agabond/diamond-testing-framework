// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

import {IAdd1Facet} from "../../interfaces/add/IAdd1Facet.sol";

contract Add1Facet is IAdd1Facet {
    function whoami1() external pure returns (string memory) {
        return "Add1Facet";
    }

    function add1(uint256 _value) external pure returns (uint256) {
        return 1 + _value;
    }

    function add1error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }
}
