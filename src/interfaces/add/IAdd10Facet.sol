// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/



interface IAdd10Facet {
    function whoami10() external view returns (string memory);
    function add10(uint256 input) external returns (uint256);
    function add10error() external pure;
}
