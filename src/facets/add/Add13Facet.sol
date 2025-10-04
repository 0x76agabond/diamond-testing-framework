// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz13504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd13Facet } from "../../interfaces/add/IAdd13Facet.sol";

contract Add13Facet is IAdd13Facet {
   
    function whoami13() external pure returns (string memory)
    {
        return "Add13Facet";
    }

    function add13(uint256 _value) external pure returns (uint256) {
        return 13 + _value;
    }

    function add13error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
