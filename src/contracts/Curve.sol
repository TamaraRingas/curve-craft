// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/*
   ___           __              __ 
  / __\ /\ /\   /__\  /\   /\   /__\
 / /   / / \ \ / \//  \ \ / /  /_\  
/ /___ \ \_/ // _  \   \ V /  //__  
\____/  \___/ \/ \_/    \_/   \__/  
*/

import "@openzeppelin/token/ERC20/IERC20.sol";
import "@openzeppelin/access/Ownable2Step.sol";
import "@openzeppelin/token/ERC20/utils/SafeERC20.sol"; 

import "../interfaces/ICurveFactory.sol";
import "../interfaces/ICurve.sol";


contract Curve is ICurve, Ownable2Step {
    using SafeERC20 for IERC20;

    // =================== STATE VARIABLES =================== //

    IERC20 USDC;
    ICurveFactory factory;

    address public marketTransitionAddress;
    address transitionContract;
    address uniswapRouter;
    address tokenAddress;
    address curveFactory; // Is this necessary? 
    address priceOracle;
    address treasury;

    uint256 public price;
    uint256 public tokensSold;
    uint256 public percentFee;
    uint256 public minThreshold;
    uint256 public maxThreshold;
    uint256 public timeoutPeriod;

    bool public curveActive;
    bool public hasTransitioned;
    bool public transitionConditionsMet;

    // =================== MODIFIERS =================== //

    modifier isActive() {
        if (!curveActive) revert Paused();
        _;
    }

    modifier onlyPausers() {
        require(msg.sender == owner() || msg.sender == marketTransitionAddress, "Caller is not a pauser");
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
        uniswapRouter = _uniswapRouter;
        tokenAddress = _tokenAddress;
        curveFactory = _curveFactory;
        priceOracle = _priceOracle;
        treasury = _treasury;

        factory = ICurveFactory(curveFactory);
        USDC = IERC20(_collateralToken);

        // Activate the curve
        curveActive = true;
    }

    // =================== OWNER FUNCTIONS =================== //

    function initializeCurve(uint256 _maxThreshold, uint256 _minThreshold, uint256 _timeoutPeriod) external onlyOwner() {
        maxThreshold = _maxThreshold;
        minThreshold = _minThreshold;
        timeoutPeriod = _timeoutPeriod;
    }

    function toggleCurveActive() external onlyPausers() {
        curveActive = false ? true : false;
    }

    // =================== EXTERNAL FUNCTIONS =================== //

    function sellMISC(uint256 amount) external isActive() {

        tokensSold -= amount;
    }

    function buyMISC(uint256 amount) external isActive() {
        //require(amount <= maxThreshold, "Amount exceeds max threshold");
        //require(amount >= minThreshold, "Amount is below min threshold");
        tokensSold += amount;
    }

    // function withdrawCollateral(uint256 _amount) public onlyOwner {
    //     require(hasTransitioned, "Curve has not transitioned");
    //     if (_amount <= 0) revert NoZeroWithdrawals();
    //     if (_amount > USDC.balanceOf(address(this))) revert InsufficientFunds();
    //     address owner = owner();
    //     USDC.transfer(owner, _amount);

    //     emit CollateralWithdrawn(owner, _amount);
    // }

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