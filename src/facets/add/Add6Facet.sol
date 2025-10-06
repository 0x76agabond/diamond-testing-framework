// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

import {IAdd6Facet} from "../../interfaces/add/IAdd6Facet.sol";

contract Add6Facet is IAdd6Facet {
    function whoami6() external pure returns (string memory) {
        return "Add6Facet";
    }

    function add6(uint256 _value) external pure returns (uint256) {
        return 6 + _value;
    }

    function add6error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }
}
