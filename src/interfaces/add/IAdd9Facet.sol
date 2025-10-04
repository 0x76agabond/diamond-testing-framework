// SPDX-License-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\n* Author: Hoang <ginz1504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

interface IAdd9Facet {
    function whoami9()external view returns (string memory);
    function add9(uint256 _value) external pure returns (uint256);
    function add9error() external pure;
    
}
