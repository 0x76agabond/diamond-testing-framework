// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz1504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd3Facet } from "../../interfaces/add/IAdd3Facet.sol";

contract Add3Facet is IAdd3Facet {
   
    function whoami3() external pure returns (string memory)
    {
        return "Add3Facet";
    }

    function add3(uint256 _value) external pure returns (uint256) {
        return 3 + _value;
    }

    function add3error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
