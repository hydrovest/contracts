import { createPublicClient } from "viem";
import { arbitrumSepolia } from "viem/chains";

import { TRANSPORT } from "./constants";

export const connectToBlockchainWithRPC = async () => {
  const publicClient = createPublicClient({
    chain: arbitrumSepolia,
    transport: TRANSPORT,
  });

  return publicClient;
};
