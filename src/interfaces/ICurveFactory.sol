// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/* ___    _      ___  _____    ___    __       
  / __\  /_\    / __\/__   \  /___\  /__\ /\_/\
 / _\   //_\\  / /     / /\/ //  // / \// \_ _/
/ /    /  _  \/ /___  / /   / \_// / _  \  / \ 
\/     \_/ \_/\____/  \/    \___/  \/ \_/  \_/ 
********************************************/

interface ICurveFactory {
    /*//////////////////////////////////////////////////////////////
                            GETTERS
    //////////////////////////////////////////////////////////////*/

    function getCurveAddress(uint256 _curveId) external view returns (address);

    function getPriceFormulaAddress(uint256 _formula) external view returns (address);

    function getMarketAddress(address _curveAddress) external view returns (address);

    /*//////////////////////////////////////////////////////////////
                            GENERAL
    //////////////////////////////////////////////////////////////*/

    function createBondingCurve(
        string memory _tokenName,
        string memory _tokenSymbol,
        address _uniswapRouter,
        address _marketTransition,
        address _formula
    ) external returns (address[2] memory);
}