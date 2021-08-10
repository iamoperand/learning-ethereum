// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

/*
  AIM: Allow anyone to rent a hotel room.
    - check if the room is "vacant"
    - allow customer to pay and change the room's status from "vacant" to "occupied"
*/


contract HotelRoom {
  enum Statuses {Vacant, Occupied}
  Statuses currentStatus;

  event Occupy(address _occupant, uint _value);

  address payable public owner;

  constructor() {
    owner = msg.sender;
    currentStatus = Statuses.Vacant;
  }

  modifier onlyWhenVacant {
    require(currentStatus == Statuses.Vacant, "Not vacant.");
    _;
  }

  modifier costs(uint _amount) {
    require(msg.value >= _amount, "Not enough ether provided");
    _;
  }

  function book() external payable onlyWhenVacant costs(2 ether) {
    currentStatus = Statuses.Occupied;
    owner.transfer(msg.value);
    emit Occupy(msg.sender, msg.value);
  }
}