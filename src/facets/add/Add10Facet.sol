// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz10504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd10Facet } from "../../interfaces/add/IAdd10Facet.sol";

contract Add10Facet is IAdd10Facet {
   
    function whoami10() external pure returns (string memory)
    {
        return "Add10Facet";
    }

    function add10(uint256 _value) external pure returns (uint256) {
        return 10 + _value;
    }

    function add10error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
