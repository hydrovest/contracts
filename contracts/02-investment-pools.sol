// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {HydroToken} from "./01-hydro-token.sol";

contract InvestmentPools is Ownable {
    struct Pool {
        uint256 hydroBalance;
        uint256 usdcBalance;
        uint256 maxHydroTokens;
    }

    uint256 public exchangeRate;
    HydroToken public hydroToken;
    IERC20 public usdcToken;
    mapping(uint256 => Pool) public pools;
    mapping(uint256 => mapping(address => uint256)) public userHydroBalance;
    uint256 public poolCount;

    event UserDeposited(
        uint256 indexed poolId,
        address indexed user,
        uint256 hydroAmount,
        uint256 usdcAmount
    );
    event UserWithdraw(
        uint256 indexed poolId,
        address indexed user,
        uint256 hydroAmount,
        uint256 usdcAmount
    );
    event PoolWithdrawn(
        uint256 indexed poolId,
        address indexed recipient,
        uint256 usdcAmount
    );
    event MaxHydroTokensUpdated(uint256 indexed poolId, uint256 maxHydroTokens);

    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        IERC20 _usdcToken,
        uint256 _exchangeRate
    ) Ownable(msg.sender) {
        hydroToken = new HydroToken(tokenName, tokenSymbol);
        usdcToken = _usdcToken;
        exchangeRate = _exchangeRate;
    }

    function createPool(uint256 _maxHydroTokens) external onlyOwner {
        pools[poolCount] = Pool({
            hydroBalance: 0,
            usdcBalance: 0,
            maxHydroTokens: _maxHydroTokens
        });
        poolCount++;
    }

    function setExchangeRate(uint256 newRate) external onlyOwner {
        exchangeRate = newRate;
    }

    function setMaxHydroTokens(
        uint256 poolId,
        uint256 _maxHydroTokens
    ) external onlyOwner {
        pools[poolId].maxHydroTokens = _maxHydroTokens;
        emit MaxHydroTokensUpdated(poolId, _maxHydroTokens);
    }

    function purchaseTokens(uint256 usdcAmount) external {
        require(usdcAmount > 0, "Amount must be greater than zero");

        usdcToken.transferFrom(msg.sender, address(this), usdcAmount);
        hydroToken.mint(msg.sender, usdcAmount * exchangeRate);
    }

    function returnTokens(uint256 hydroAmount) external {
        require(hydroAmount > 0, "Amount must be greater than zero");

        hydroToken.burnFrom(msg.sender, hydroAmount);
        usdcToken.transfer(msg.sender, hydroAmount / exchangeRate);
    }

    function userDeposit(uint256 poolId, uint256 hydroAmount) external {
        require(hydroAmount > 0, "Amount must be greater than zero");

        Pool storage pool = pools[poolId];
        require(
            pool.hydroBalance + hydroAmount <= pool.maxHydroTokens,
            "Exceeds max HYDRO tokens allowed"
        );

        pool.hydroBalance += hydroAmount;
        pool.usdcBalance += hydroAmount / exchangeRate;
        userHydroBalance[poolId][msg.sender] += hydroAmount;
        hydroToken.transferFrom(msg.sender, address(this), hydroAmount);

        emit UserDeposited(
            poolId,
            msg.sender,
            hydroAmount,
            hydroAmount / exchangeRate
        );
    }

    function userWithdraw(uint256 poolId, uint256 hydroAmount) external {
        require(hydroAmount > 0, "Amount must be greater than zero");

        Pool storage pool = pools[poolId];
        uint256 userBalance = userHydroBalance[poolId][msg.sender];

        require(userBalance >= hydroAmount, "Insufficient user balance");

        pool.hydroBalance -= hydroAmount;
        pool.usdcBalance -= hydroAmount / exchangeRate;
        userHydroBalance[poolId][msg.sender] -= hydroAmount;
        hydroToken.transfer(msg.sender, hydroAmount);

        emit UserWithdraw(
            poolId,
            msg.sender,
            hydroAmount,
            hydroAmount / exchangeRate
        );
    }

    function withdrawPool(
        uint256 poolId,
        address recipient,
        uint256 amount
    ) external onlyOwner {
        require(amount > 0, "Amount must be greater than zero");

        Pool storage pool = pools[poolId];
        require(pool.usdcBalance >= amount, "Insufficient USDC balance");

        pool.usdcBalance -= amount;
        usdcToken.transfer(recipient, amount);

        emit PoolWithdrawn(poolId, recipient, amount);
    }
}
