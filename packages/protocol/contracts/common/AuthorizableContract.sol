pragma solidity ^0.8.20;

import { EssentialContract } from "../common/EssentialContract.sol";

/// @title AuthorizableContract
/// @notice Every contract which needs to have authorization (EtherVault,
/// ERCXXVault)
contract AuthorizableContract is EssentialContract {
    /// @dev Initialization method for setting up AddressManager reference.
    /// @param _addressManager Address of the AddressManager.
    function _init(address _addressManager) internal virtual override {
        EssentialContract._init(_addressManager);
    }
}