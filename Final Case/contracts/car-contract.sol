// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ownable.sol";
import "./safemath.sol";

library CarGalery {

    function changeName() public pure {

    }

    function putOnSale() public {

    }

    function changePrice() public {

    }
}

contract car_production is Ownable{

    using SafeMath for uint256;

    address ownerAddress;

    struct Car {
        string brand;
        uint price;
        bool isSecondHand;
        bool is_selling;
    }

    

    Car[] on_sale_cars;
    Car[] cars;  

    mapping(uint => address) carToOwner;
    mapping(address => uint) customer_car_count;

    constructor() {
        ownerAddress = msg.sender;
    }

    // modifier _is_there(uint car_Id) {
    //     require(cars[car_Id], "Car already joined the chain!");
    //     _;
    // }

    modifier _isRightOwner(uint _car_Id) {
        require(carToOwner[_car_Id] == msg.sender, "You are not the owner of this car!");
        _;
    }


    function createCar(string memory _brand, uint _price) public {

        uint carId; 
        carId += 1;
        cars.push(Car(_brand, _price, false, false));

        carToOwner[carId] = msg.sender;
        customer_car_count[msg.sender] = customer_car_count[msg.sender].add(1);
    }

    function buy_car(uint _Id ) public {
        carToOwner[_Id] = msg.sender;
        customer_car_count[msg.sender] = customer_car_count[msg.sender].add(1);
    }

    function putOnSale(uint _car_Id) public {
        on_sale_cars.push(cars[_car_Id]);
        on_sale_cars[_car_Id].is_selling = true;
    }

    function changePrice() public {

    }

    function getCarsByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](customer_car_count[_owner]);
        uint counter = 0;
        for (uint i = 0; i < cars.length; i++) {
        if (carToOwner[i] == _owner) {
            result[counter] = i;
            counter++;
        }
        }
        return result;
  }

}
