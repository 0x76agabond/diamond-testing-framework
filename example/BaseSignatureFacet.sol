// SPDX-License-Identifier: LicenseRef-Proprietary
/* 
   Proprietary License

   © 2025 [Jilnesta]. All rights reserved.

   This contract is proprietary software. It may only be used, copied, modified, or distributed 
   by [Jilnesta], or with written permission from [Jilnesta].

   Unauthorized use is strictly prohibited.

   https://github.com/0x76agabond
   
*/

pragma solidity >=0.8.0 <0.9.0;

import {Enum} from "./../libraries/Enum.sol";
import {LibFVSFAdmin} from "./../libraries/LibFVSFAdmin.sol";
import {LibFVSF} from "./../libraries/LibFVSF.sol";
import {LibDiamond} from "./../libraries/LibDiamond.sol";

contract BaseSignatureFacet 
{
    // ===================================================================
    // Signature Check
    // ===================================================================

      /*
    
    this will check if admin / specific signer is in signatures

    ctype == 1 admin sys 
    ctype == 2 admin trans
    
    */

    function _validateSignatures(bytes memory signatures) internal pure {
        require(signatures.length > 0, "No signatures");
        require(signatures.length % LibFVSF.SIGNATURE_SIZE == 0, "Invalid signature format");
    }

    function _recoverSigner(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal pure returns (address signer)
    {
        if (v < 27) {
            if (s == bytes32(0) && v == 1) {
                // Binance-style signature
                signer = address(uint160(uint256(r)));
            } else {
                signer = ecrecover(hash, v + 27, r, s);
            }
        } else if (v > 30) {
            // Gnosis-style ETH_SIGN
            bytes32 signed = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
            signer = ecrecover(signed, v - 4, r, s);
        } else {
            // Standard EOA
            signer = ecrecover(hash, v, r, s);
        }
    }

    function baseCheckSignatureAdmin(Enum.Admin ctype,bytes32 txHash,bytes memory signatures) internal  view returns (bool) {
        LibFVSFAdmin.Attr storage s = LibFVSFAdmin.get();

        _validateSignatures(signatures);

        for (uint256 i = 0; i < signatures.length; i += LibFVSF.SIGNATURE_SIZE) {
            (uint8 v, bytes32 r, bytes32 s_) = LibFVSF.signatureSplit(signatures, i);
            address owner = _recoverSigner(txHash, v, r, s_);

            require(owner != address(0), "Recovered zero address");

            if (ctype == Enum.Admin.Sys && s.sys_admins[owner]) return true;
            if (ctype == Enum.Admin.Trans && s.trans_admins[owner]) return true;
        }

        return false;
    }

    /*
    
    this will check if boss is in signatures
    
    */
    
    function baseCheckSignatureOwner(bytes32 txHash,bytes memory signatures) internal view returns (bool) {            
        return baseCheckSignatureAccount(txHash, signatures, LibDiamond.contractOwner());
    }

    function baseCheckSignatureAccount(bytes32 txHash,bytes memory signatures, address target) internal pure returns (bool) 
    {
        _validateSignatures(signatures);
        
        for (uint256 i = 0; i < signatures.length; i += LibFVSF.SIGNATURE_SIZE) {
            (uint8 v, bytes32 r, bytes32 s_) = LibFVSF.signatureSplit(signatures, i);
            address recovered = _recoverSigner(txHash, v, r, s_);
            require(recovered != address(0), "Invalid Owner");

            if (recovered == target) {
                return true;
            }
        }

        return false;
    }
}