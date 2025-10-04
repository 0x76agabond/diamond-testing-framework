// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz5504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

import { IAdd5Facet } from "../../interfaces/add/IAdd5Facet.sol";

contract Add5Facet is IAdd5Facet {
   
    function whoami5() external pure returns (string memory)
    {
        return "Add5Facet";
    }

    function add5(uint256 _value) external pure returns (uint256) {
        return 5 + _value;
    }

    function add5error() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }

}
