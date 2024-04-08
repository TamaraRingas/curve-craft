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

import "../libraries/ICurve.sol";

contract Curve is ICurve, Ownable2Step {
    // =================== STATE VARIABLES =================== //

    address public marketTransitionAddress;

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

    constructor (address _marketTransitionAddress) Ownable(msg.sender) {
        curveActive = true;
        marketTransitionAddress =  _marketTransitionAddress;
    }

    function initializeCurve(uint256 _maxThreshold, uint256 _minThreshold, uint256 _timeoutPeriod) external onlyOwner() {
        maxThreshold = _maxThreshold;
        minThreshold = _minThreshold;
        timeoutPeriod = _timeoutPeriod;
    }

    function activateCurve() external onlyOwner() {
        curveActive = true;
    }
    
    function pauseCurve() external onlyOwner() {
        curveActive = false;
    }

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

    function getMarketTransitionAddress() external view returns (address) {
        return marketTransitionAddress;
    }

    function getTokensSold() external view returns (uint256) {
        return tokensSold;
    }
}