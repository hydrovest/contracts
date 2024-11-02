import { task, type HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";

import {
  ETHERSCAN_API,
  RPC_URL,
  USER_PRIVATE_KEY,
} from "./scripts/helpers/constants";

const config: HardhatUserConfig = {
  solidity: "0.8.27",
  networks: {
    arbitrumSepolia: {
      url: RPC_URL,
      accounts: [USER_PRIVATE_KEY],
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: {
      arbitrumSepolia: ETHERSCAN_API,
    },
  },
  sourcify: {
    // Disabled by default
    // Doesn't need an API key
    enabled: true,
  },
};

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.viem.getWalletClients();
  for (const account of accounts) {
    console.log(account.account.address);
  }
});

export default config;
