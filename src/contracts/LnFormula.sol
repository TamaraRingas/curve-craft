// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/*
 _         
| | _ __   
| || '_ \  
| || | | | 
|_||_| |_| 
***********/

import "../interfaces/ICurve.sol";

contract LnFormula {
  /*//////////////////////////////////////////////////////////////
                           STATE VARIABLES
  //////////////////////////////////////////////////////////////*/

  address curveAddress;
  ICurve curve;

  constructor(address _curveAddress) {
    curveAddress = _curveAddress;
    curve = ICurve(_curveAddress);
  }

  /*//////////////////////////////////////////////////////////////
                         EXTERNAL FUNCTIONS
  //////////////////////////////////////////////////////////////*/

  /// @notice Determines the price for an input amount of MISC, in ETH.
  /// @dev The price is calculated as the integral between the endPoint(The amount of tokens sold after the user has bought the input amount) and the startPoint(the amount of tokens bought before the quote was requested) along the shifted cos curve.
  /// @param amountMISC - The amount of MISC the user wishes to recieve a quote for in ETH.
  function calculatePrice(uint256 amountMISC) external view returns (uint256 price) {
    return 0;
  }
}