// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz9504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd9Facet } from "../../interfaces/add/IAdd9Facet.sol";

contract Add9Facet is IAdd9Facet {
   
    function whoami9() external pure returns (string memory)
    {
        return "Add9Facet";
    }

    function add9(uint256 _value) external pure returns (uint256) {
        return 9 + _value;
    }

    function add9error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
