// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

import {IAdd16Facet} from "../../interfaces/add/IAdd16Facet.sol";

contract Add16Facet is IAdd16Facet {
    function whoami16() external pure returns (string memory) {
        return "Add16Facet";
    }

    function add16(uint256 input) external pure returns (uint256) {
        return input + 16;
    }

    function add16error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }
}
