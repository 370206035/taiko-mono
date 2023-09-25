// SPDX-License-Identifier: MIT
//  _____     _ _         _         _
// |_   _|_ _(_) |_____  | |   __ _| |__ ___
//   | |/ _` | | / / _ \ | |__/ _` | '_ (_-<
//   |_|\__,_|_|_\_\___/ |____\__,_|_.__/__/

pragma solidity ^0.8.20;

import { ITierProvider, LibTiers } from "./ITierProvider.sol";

/// @title OPL2ConfigProvider
contract OPL2ConfigProvider is ITierProvider {
    error TIER_NOT_FOUND();

    function getTier(uint16 tierId)
        public
        pure
        override
        returns (ITierProvider.Tier memory)
    {
        if (tierId == LibTiers.TIER_OPTIMISTIC) {
            return ITierProvider.Tier({
                verifierName: "tier_optimistic",
                proofBond: 100_000 ether, // TKO
                contestBond: 100_000 ether, // TKO
                cooldownWindow: 4 hours,
                provingWindow: 20 minutes
            });
        }

        if (tierId == LibTiers.TIER_SGX) {
            return ITierProvider.Tier({
                verifierName: "tier_sgx",
                proofBond: 50_000 ether, // TKO
                contestBond: 50_000 ether, // TKO
                cooldownWindow: 3 hours,
                provingWindow: 60 minutes
            });
        }

        if (tierId == LibTiers.TIER_PSE_ZKEVM) {
            return ITierProvider.Tier({
                verifierName: "tier_pse_zkevm",
                proofBond: 10_000 ether, // TKO
                contestBond: 10_000 ether, // TKO
                cooldownWindow: 2 hours,
                provingWindow: 90 minutes
            });
        }

        if (tierId == LibTiers.TIER_GUARDIAN) {
            return ITierProvider.Tier({
                verifierName: "tier_guardian",
                proofBond: 0,
                contestBond: 0, // not contestable
                cooldownWindow: 1 hours,
                provingWindow: 120 minutes
            });
        }

        revert TIER_NOT_FOUND();
    }

    function getTierIds()
        public
        pure
        override
        returns (uint16[] memory tiers)
    {
        tiers = new uint16[](4);
        tiers[0] = LibTiers.TIER_OPTIMISTIC;
        tiers[1] = LibTiers.TIER_SGX;
        tiers[2] = LibTiers.TIER_PSE_ZKEVM;
        tiers[3] = LibTiers.TIER_GUARDIAN;
    }

    function getMinTier(uint256 rand) public pure override returns (uint16) {
        if (rand % 100 == 0) return LibTiers.TIER_PSE_ZKEVM;
        // else if (rand % 10 == 0) return LibTiers.TIER_SGX;
        else return LibTiers.TIER_OPTIMISTIC;
    }
}