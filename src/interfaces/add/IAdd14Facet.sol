// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/******************************************************************************\
* Author: Hoang <ginz1504@gmail.com>
* Contact: https://github.com/0x76agabond 
* =============================================================================
* Diamond Testing via OOP (DTO)
/******************************************************************************/

interface IAdd14Facet {
    function whoami14()external view returns (string memory);
    function add14(uint256 _value) external pure returns (uint256);
    function add14error() external pure;
    
}
