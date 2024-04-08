// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/*
   ___           __              __ 
  / __\ /\ /\   /__\  /\   /\   /__\
 / /   / / \ \ / \//  \ \ / /  /_\  
/ /___ \ \_/ // _  \   \ V /  //__  
\____/  \___/ \/ \_/    \_/   \__/  
*/

import "../libraries/ICurve.sol";

contract Curve is ICurve {
    // =================== STATE VARIABLES =================== //

    uint256 public maxThreshold;
    uint256 public minThreshold;
    uint256 public timeoutPeriod;
    uint256 public tokensSold;
    uint256 public percentFee;
    uint256 public price;
    
    bool public curveActive;

    address public marketTransitionAddress;

    // =================== MODIFIERS =================== //

    modifier isActive() {
        if (!curveActive) revert Paused();
        _;
    }

    constructor () {

    }

    function initializeCurve(uint256 _maxThreshold, uint256 _minThreshold, uint256 _timeoutPeriod) external {
        maxThreshold = _maxThreshold;
        minThreshold = _minThreshold;
        timeoutPeriod = _timeoutPeriod;
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
    
    function sellMISC(uint256 amount) external {
        require(curveActive, "Curve is not active");
        //require(amount <= maxThreshold, "Amount exceeds max threshold");
        //require(amount >= minThreshold, "Amount is below min threshold");
        tokensSold += amount;
    }

    function buyMISC(uint256 amount) external {
        require(curveActive, "Curve is not active");
        //require(amount <= maxThreshold, "Amount exceeds max threshold");
        //require(amount >= minThreshold, "Amount is below min threshold");
        tokensSold -= amount;
    }
    
    function activateCurve() external {
        curveActive = true;
    }
    
    function pauseCurve() external {
        curveActive = false;
    }
}