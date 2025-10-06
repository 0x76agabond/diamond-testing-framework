// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

import {IAdd4Facet} from "../../interfaces/add/IAdd4Facet.sol";

contract Add4Facet is IAdd4Facet {
    function whoami4() external pure returns (string memory) {
        return "Add4Facet";
    }

    function add4(uint256 _value) external pure returns (uint256) {
        return 4 + _value;
    }

    function add4error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }
}
