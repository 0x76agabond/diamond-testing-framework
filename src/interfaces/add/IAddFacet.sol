// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IAddFacet {
    function addValue(uint256 _value) external view returns (uint256);
    function init(uint256 _initialValue) external;
    function getValue() external view returns (uint256);
    function adderror() external pure;
}
