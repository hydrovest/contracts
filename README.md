# HydroVest Contracts Collection

## Table of Contents

- [Overview](#overview)
- [Deployed Contracts](#deployed-contracts)
- [Prerequisites](#prerequisites)
- [Setup and Installation](#setup-and-installation)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contribution Guidelines](#contribution-guidelines)
- [License](#license)
- [Stay in touch](#stay-in-touch)

## Overview

The **HydroVest Contracts Collection** repository includes smart contracts for a decentralized investment platform. The main components are:

- **Mock USDC**: A mock version of the USDC stablecoin for testing purposes.
- **Investment Pools**: Smart contracts for managing user investments.
- **HydroToken**: A native token representing stake in the platform.

This collection is deployed on the Arbitrum Sepolia testnet, providing a sandbox environment for development and testing.

## Deployed Contracts

- **MockUSDC**: `0x37dF3a69d950592c202fc99AB1cd9877F6da00Ab`
- **InvestmentPools**: `0xfC4C0aCdC54C57c12C9fC8eF22B6759abA26E77d`
- **HydroToken**: `0x4F66C8E76820ab8f77Bbbf239234bea31433E0B1`

## Prerequisites

To deploy and interact with the contracts, ensure you have:

1. **Alchemy Account**: Obtain an `ALCHEMY_API_KEY` from [Alchemy](https://www.alchemy.com/).
2. **MetaMask Wallet**: Export your wallet’s `PRIVATE_KEY`.
3. **Arbiscan Account**: Sign up at [Arbiscan](https://arbiscan.io/) to get an `ARBISCAN_API_KEY`.
4. **ETH Arbitrum Sepolia Balance**: For Arbitrum Sepolia testnet gas fees, use an Arbitrum Sepolia faucet to obtain ETH from the [Alchemy Faucet](https://www.alchemy.com/faucets/arbitrum-sepolia).
5. **Node and Yarn**: Confirm `Node.js` is installed and use `Yarn` as the package manager:
   - Node.js: `>=20.x`
   - Yarn Classic: `4.4.1`

## Setup and Installation

1. **Clone the repository**:

   ```bash
      git clone https://github.com/hydrovest/contracts.git
      cd contracts
   ```

2. **Environment Configuration**:

   - Create a `.env` file in the root directory.
   - Copy the contents of `.env.example` and replace placeholder values with your actual credentials.

3. **Install dependencies**:

   ```bash
      yarn install
   ```

4. **Compile contracts**:
   ```bash
      yarn compile
   ```

## Usage

To deploy and verify contracts, use the following commands:

### Deploy Contracts

- **Mock USDC Token**:

  ```bash
     yarn deploy:usdc
  ```

- **Investment Pools (includes HydroToken)**:

  ```bash
     yarn deploy:investment:pools
  ```

### Verify Contracts on Sepolia Etherscan

Replace `contractAddress` with the actual contract addresses:

```bash
   yarn verify:hydro:token "hydroTokenContractAddress"
   yarn verify:investment:pools "investmentPoolsContractAddress"
   yarn verify:mock:usdc "mockUsdcContractAddress"
```

## Troubleshooting

If you encounter issues, here are some tips:

- **Environment Variables Not Loading**: Ensure `.env` is correctly formatted and that required keys are populated.
- **Deployment Errors**: Check that you have sufficient ETH balance in your Sepolia wallet.
- **Contract Verification Failures**: Ensure the contract addresses are accurate and deployments have been confirmed.

## Contribution Guidelines

We welcome contributions from the community! Please read our [contributing guidelines](CONTRIBUTING.md) before submitting a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.

## Stay in touch

- Author - [Septian Maulana](https://www.tianweb.dev)
