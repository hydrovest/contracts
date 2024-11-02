import {
  EXCHANGE_RATE,
  TOKEN_NAME,
  TOKEN_SYMBOL,
} from "../scripts/02-deployment-investment-pools";
import { USDC_CONTRACT_ADDRESS } from "../scripts/helpers/constants";

module.exports = [
  TOKEN_NAME,
  TOKEN_SYMBOL,
  USDC_CONTRACT_ADDRESS,
  EXCHANGE_RATE,
];
