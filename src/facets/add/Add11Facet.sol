// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz11504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd11Facet } from "../../interfaces/add/IAdd11Facet.sol";

contract Add11Facet is IAdd11Facet {
   
    function whoami11() external pure returns (string memory)
    {
        return "Add11Facet";
    }

    function add11(uint256 _value) external pure returns (uint256) {
        return 11 + _value;
    }

    function add11error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
