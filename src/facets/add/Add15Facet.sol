// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

import {IAdd15Facet} from "../../interfaces/add/IAdd15Facet.sol";

contract Add15Facet is IAdd15Facet {
    function whoami15() external pure returns (string memory) {
        return "Add15Facet";
    }

    function add15(uint256 _value) external pure returns (uint256) {
        return 15 + _value;
    }

    function add15error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }
}
