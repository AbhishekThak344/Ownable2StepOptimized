//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
abstract contract Ownable {
  address public owner; 
  address public pendingOwner;
                         
  event ownershipTransferStarted (address indexed newPurposedOwner, address indexed prevOwner);
  event ownershipTransferSuccessful (address indexed Owner);
  event ownershipRenounced(address indexed zeroAddress);


  /**
   * @dev Initializes the contract setting the deployer as the initial owner.
   */
  constructor (){
   owner = msg.sender;
   }

  /**
   *@dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
      require(owner == msg.sender,"Ownable: You're not the owner");
        _;
    }

  /**
   *@dev Throws if called by any account other than the pending owner.
   */  

  modifier onlyPendingOwner() {
   require(pendingOwner == msg.sender, "Ownable: you're not the pending Owner");
    _;
  }

  /**
   * @dev initiate the ownership of the contract to a new account (`pendingOwner`).
   * Can only be called by the current owner.
   */

  function transferOwnership (address _pendingOwner) external onlyOwner{  
    require (_pendingOwner != address(0), "Ownable: use renounce ownership for that :D"); 
    require (pendingOwner != _pendingOwner, "Ownable: already a pending owner");
    pendingOwner = _pendingOwner;
    emit ownershipTransferStarted (pendingOwner, owner);
  }

  /**
    * @dev Transfers ownership of the contract to a new account (`pendingOwner`) and deletes any pending owner.
    */
  function acceptOwnership () external onlyPendingOwner {
  owner = pendingOwner;
  delete pendingOwner;
  emit ownershipTransferSuccessful(owner);
  }
  
 
  /**
  * @dev Leaves the contract without owner. It will not be possible to call
  * `onlyOwner` functions anymore. Can only be called by the current owner.
  *
  * NOTE: Renouncing ownership will leave the contract without an owner,
  * thereby removing any functionality that is only available to the owner.
  */  

  function renounceOwnership () external onlyOwner { 
  owner = address(0);
  emit ownershipRenounced(owner);
  }

}
