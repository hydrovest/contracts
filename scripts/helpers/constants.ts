import { http } from "viem";
import * as dotenv from "dotenv";

dotenv.config();

export const PROVIDER_API = process.env.ALCHEMY_API_KEY || "";
export const USER_PRIVATE_KEY = process.env.PRIVATE_KEY || "";
export const ADDRESS_REGEX = /^0x[a-fA-F0-9]{40}$/;
export const RPC_URL = "https://neoxt4seed1.ngd.network";
export const TRANSPORT = http(RPC_URL);
export const ETHERSCAN_API = process.env.ETHERSCAN_API_KEY || "";
export const USDC_CONTRACT_ADDRESS = process.env.USDC_CONTRACT_ADDRESS || "";
