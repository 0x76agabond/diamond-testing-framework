// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz7504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd7Facet } from "../../interfaces/add/IAdd7Facet.sol";

contract Add7Facet is IAdd7Facet {
   
    function whoami7() external pure returns (string memory)
    {
        return "Add7Facet";
    }

    function add7(uint256 _value) external pure returns (uint256) {
        return 7 + _value;
    }

    function add7error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
