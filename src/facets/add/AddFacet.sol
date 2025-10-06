// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "../../interfaces/add/IAddFacet.sol";

/*
/// Author: Hoang <ginz1504@gmail.com>
/// Contact: https://github.com/0x76agabond
/// =============================================================================
/// Diamond Testing via OOP (DTO)
*/

contract AddFacet is IAddFacet {
    uint256 private s_value;

    function init(uint256 _initialValue) external {
        s_value = _initialValue;
    }

    function addValue(uint256 _value) external view returns (uint256) {
        return s_value + _value;
    }

    function getValue() external view returns (uint256) {
        return s_value;
    }

    function adderror() external pure {
        uint256 x = 1;
        uint256 y = 0;
        x = x / y; // Division by zero to cause a revert
    }
}
