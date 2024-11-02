import { createPublicClient } from "viem";
import { arbitrum } from "viem/chains";

import { TRANSPORT } from "./constants";

export const connectToBlockchainWithRPC = async () => {
  const publicClient = createPublicClient({
    chain: arbitrum,
    transport: TRANSPORT,
  });

  return publicClient;
};
