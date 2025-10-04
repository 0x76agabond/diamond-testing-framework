// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz8504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd8Facet } from "../../interfaces/add/IAdd8Facet.sol";

contract Add8Facet is IAdd8Facet {
   
    function whoami8() external pure returns (string memory)
    {
        return "Add8Facet";
    }

    function add8(uint256 _value) external pure returns (uint256) {
        return 8 + _value;
    }

    function add8error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
