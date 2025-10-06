// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

import {IAdd14Facet} from "../../interfaces/add/IAdd14Facet.sol";

contract Add14Facet is IAdd14Facet {
    function whoami14() external pure returns (string memory) {
        return "Add14Facet";
    }

    function add14(uint256 _value) external pure returns (uint256) {
        return 14 + _value;
    }

    function add14error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }
}
