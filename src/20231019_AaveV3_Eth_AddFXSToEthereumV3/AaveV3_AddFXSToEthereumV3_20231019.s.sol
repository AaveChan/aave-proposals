// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_AddFXSToEthereumV3_20231019} from './AaveV3_Ethereum_AddFXSToEthereumV3_20231019.sol';

/**
 * @dev Deploy AaveV3_Ethereum_AddFXSToEthereumV3_20231019
 * command: make deploy-ledger contract=src/20231019_AaveV3_Eth_AddFXSToEthereumV3/AaveV3_AddFXSToEthereumV3_20231019.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_AddFXSToEthereumV3_20231019();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231019_AaveV3_Eth_AddFXSToEthereumV3/AaveV3_AddFXSToEthereumV3_20231019.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231019_AaveV3_Eth_AddFXSToEthereumV3/AddFXSToEthereumV3.md'
      )
    );
  }
}
