// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/* ___    _      ___  _____    ___    __       
  / __\  /_\    / __\/__   \  /___\  /__\ /\_/\
 / _\   //_\\  / /     / /\/ //  // / \// \_ _/
/ /    /  _  \/ /___  / /   / \_// / _  \  / \ 
\/     \_/ \_/\____/  \/    \___/  \/ \_/  \_/ 
********************************************/

import "@openzeppelin/access/Ownable2Step.sol";

contract CurveFactory is Ownable2Step {
  constructor() Ownable(msg.sender) {}
}