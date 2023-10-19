// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'lib/aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title Add FXS to Ethereum V3
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xd8a8bdf3692666195895efbe0e885887c73b614273d6f0bd584c68afa9c11600
 * - Discussion: https://governance.aave.com/t/arfc-add-fxs-to-ethereum-v3/15112
 */
contract AaveV3_Ethereum_AddFXSToEthereumV3_20231019 is AaveV3PayloadEthereum {
  address public constant FXS = 0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0;
  address public constant FXS_PRICE_FEED = 0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: FXS,
      assetSymbol: 'FXS',
      priceFeed: FXS_PRICE_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(9_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(13_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: _bpsToRay(5_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 35_00,
      liqThreshold: 45_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 800_000,
      borrowCap: 500_000,
      debtCeiling: 4_000_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
