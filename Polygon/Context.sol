// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IModule {
  function getModule(uint256 module_) external view returns (address);
}

contract Context {
  /**
   * @notice Module Manager instance
   */
  IModule moduleManager;

  /**
   * @notice Builder
   */
  constructor (address moduleManager_) {
    moduleManager = IModule(moduleManager_);
  }

  /**
   * @notice Context mixing for meta transactions
   */
  function _msgSender() public view returns (address sender) {
    if (msg.sender == moduleManager.getModule(4)) {
      assembly {
        /* Get the msg.sender */
        sender := shr(96, calldataload(sub(calldatasize(), 20)))
      }
    } else sender = msg.sender;
  }
}
