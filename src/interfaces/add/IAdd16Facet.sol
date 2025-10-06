// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

interface IAdd16Facet {
    function whoami16() external view returns (string memory);
    function add16(uint256 _value) external pure returns (uint256);
    function add16error() external pure;
}
