import { createWalletClient, Address } from "viem";
import { arbitrumSepolia } from "viem/chains";
import { privateKeyToAccount } from "viem/accounts";

import { TRANSPORT, USER_PRIVATE_KEY } from "./constants";

export const userConnectWallet = async () => {
  const account = privateKeyToAccount(`0x${USER_PRIVATE_KEY}` as Address);
  const user = createWalletClient({
    account,
    chain: arbitrumSepolia,
    transport: TRANSPORT,
  });

  return user;
};
