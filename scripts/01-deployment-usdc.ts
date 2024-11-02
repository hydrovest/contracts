import { Address } from "viem";

import {
  abi,
  bytecode,
} from "../artifacts/contracts/03-mock-usdc.sol/MockUSDC.json";

import { userConnectWallet } from "./helpers/userConnectWallet";
import { connectToBlockchainWithRPC } from "./helpers/connectToBlockchainWithRPC";

async function getUserAccount() {
  return await userConnectWallet();
}

async function getClient() {
  return await connectToBlockchainWithRPC();
}

async function main() {
  let contractAddress: Address;
  const publicClient = await getClient();
  const deployer = await getUserAccount();
  const hash = await deployer.deployContract({
    abi,
    bytecode: bytecode as `0x${string}`,
    args: [],
  });
  const receipt = await publicClient.waitForTransactionReceipt({ hash });
  if (receipt.contractAddress) {
    contractAddress = receipt.contractAddress;

    console.log(`Contract deployed at: ${contractAddress}`);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
