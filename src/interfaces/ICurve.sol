// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/*
   ___           __              __ 
  / __\ /\ /\   /__\  /\   /\   /__\
 / /   / / \ \ / \//  \ \ / /  /_\  
/ /___ \ \_/ // _  \   \ V /  //__  
\____/  \___/ \/ \_/    \_/   \__/  
*/

interface ICurve {
    // =================== EVENTS =================== //

    event NFTStageSet(string currentNFTStage, uint256 time);
    event CurvePaused(address pauser, uint256 time);
    event CurveActivated(address pauser, uint256 time);
    event CollateralWithdrawn(address drawer, uint256 time);
    event MetadexBought(int256 amountBought, address Buyer, uint256 timestamp);
    event MetadexSold(int256 amountSold, address Seller, uint256 timestamp);

    // =================== ERRORS ====================== //

    error Paused();
    error CannotBuyZero();
    error CannotSellZero();
    error IncorrectInput();
    error NoZeroWithdrawals();
    error InsufficientFunds();
    error TokensNotAvailable();
    error MaxOneMillionTokensPerTransaction();

    // =================== FUNCTIONS =================== //

    function initializeCurve(uint256 _maxThreshold, uint256 _minThreshold, uint256 _timeoutPeriod) external;

    function getFee(uint256 price) external view returns (uint256);
    
    function sellMISC(uint256 amount) external;

    function buyMISC(uint256 amount) external;
    
    function toggleCurveActive() external; 
}