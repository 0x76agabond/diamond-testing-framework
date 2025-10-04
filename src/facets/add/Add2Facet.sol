// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz2504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd2Facet } from "../../interfaces/add/IAdd2Facet.sol";

contract Add2Facet is IAdd2Facet {
   
    function whoami2() external pure returns (string memory)
    {
        return "Add2Facet";
    }

    function add2(uint256 _value) external pure returns (uint256) {
        return 2 + _value;
    }

    function add2error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
