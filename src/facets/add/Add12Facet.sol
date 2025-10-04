// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz12504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd12Facet } from "../../interfaces/add/IAdd12Facet.sol";

contract Add12Facet is IAdd12Facet {
   
    function whoami12() external pure returns (string memory)
    {
        return "Add12Facet";
    }

    function add12(uint256 _value) external pure returns (uint256) {
        return 12 + _value;
    }

    function add12error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
