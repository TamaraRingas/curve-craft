// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/*
   ___           __              __ 
  / __\ /\ /\   /__\  /\   /\   /__\
 / /   / / \ \ / \//  \ \ / /  /_\  
/ /___ \ \_/ // _  \   \ V /  //__  
\____/  \___/ \/ \_/    \_/   \__/  
*/

import "@openzeppelin/access/Ownable2Step.sol";

import "../interfaces/ICurveFactory.sol";
import "../interfaces/ICurve.sol";


contract Curve is ICurve, Ownable2Step {
    // =================== STATE VARIABLES =================== //

    ICurveFactory factory;

    address public marketTransitionAddress;
    address transitionContract;
    address collateralToken;
    address uniswapRouter;
    address tokenAddress;
    address curveFactory;
    address priceOracle;
    address treasury;

    uint256 public maxThreshold;
    uint256 public minThreshold;
    uint256 public timeoutPeriod;
    uint256 public tokensSold;
    uint256 public percentFee;
    uint256 public price;

    bool public curveActive;

    // =================== MODIFIERS =================== //

    modifier isActive() {
        if (!curveActive) revert Paused();
        _;
    }

    // =================== CONSTRUCTOR =================== //

    constructor (
      address _marketTransitionAddress,
      address _transitionContract,
      address _collateralToken,
      address _uniswapRouter,
      address _tokenAddress,
      address _curveFactory,
      address _priceOracle,
      address _treasury
      ) Ownable(msg.sender) {
        // Set initial storage variables
        marketTransitionAddress =  _marketTransitionAddress;
        transitionContract = _transitionContract;
        collateralToken = _collateralToken;
        uniswapRouter = _uniswapRouter;
        tokenAddress = _tokenAddress;
        curveFactory = _curveFactory;
        priceOracle = _priceOracle;
        treasury = _treasury;

        factory = ICurveFactory(curveFactory);

        // Activate the curve
        curveActive = true;
    }

    // =================== OWNER FUNCTIONS =================== //

    function initializeCurve(uint256 _maxThreshold, uint256 _minThreshold, uint256 _timeoutPeriod) external onlyOwner() {
        maxThreshold = _maxThreshold;
        minThreshold = _minThreshold;
        timeoutPeriod = _timeoutPeriod;
    }

    function togglePauseCurve() external onlyOwner() {
        curveActive = false ? true : false;
    }

    // =================== EXTERNAL FUNCTIONS =================== //

    function sellMISC(uint256 amount) external isActive() {
        //require(amount <= maxThreshold, "Amount exceeds max threshold");
        //require(amount >= minThreshold, "Amount is below min threshold");
        tokensSold -= amount;
    }

    function buyMISC(uint256 amount) external isActive() {
        //require(amount <= maxThreshold, "Amount exceeds max threshold");
        //require(amount >= minThreshold, "Amount is below min threshold");
        tokensSold += amount;
    }

    // function getFee(uint256 _price, uint256 _percentFee) external view returns (uint256) {
    //     return _price * _percentFee / 100;
    // }

    // =================== VIEW FUNCTIONS =================== //

    function getMarketTransitionAddress() external view returns (address) {
        return marketTransitionAddress;
    }

    function getTokensSold() external view returns (uint256) {
        return tokensSold;
    }
}