// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ownable.sol";
import "./safemath.sol";

library CarHelper {

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

    event carAdded(
        uint carId,
        address indexed owner
    );
    
    event pricaChanged(
        uint carId,
        address indexed owner,
        uint newPrice
    );

    uint carId;

    struct Car {
        string brand;
        uint price;
        bool is_second_hand;
        bool is_selling;
    }

    Car[] public on_sale_cars;
    Car[] public cars;  

    mapping(uint => address) public carToOwner;
    mapping(address => uint) public customer_car_count;

    constructor() {
        ownerAddress = msg.sender;
    }

    // checking for be sure it is owner
    modifier _isOwner(uint _car_Id) {
        require(carToOwner[_car_Id] == msg.sender, "You are not the owner of this car!");
        _;
    }


    function addYourCar(string memory _brand, uint _price) public {
        //arabanin marka ve fiyatina bakarak daha once olusturulup olusturulmadigini kontrol eden bir require. 
        carId += 1;
        cars.push(Car(_brand, _price, false, false));
        carToOwner[carId] = msg.sender;
        customer_car_count[msg.sender] = customer_car_count[msg.sender].add(1);
        emit carAdded(carId, msg.sender);
    }

    function buy_car(uint _Id) public {
        require(carToOwner[_Id] != msg.sender, "You are owner of car.");
        require(cars[_Id].is_selling, "This car is not selling!");
        customer_car_count[msg.sender] = customer_car_count[msg.sender].add(1);
        customer_car_count[carToOwner[_Id]] = customer_car_count[carToOwner[_Id]].sub(1);
        carToOwner[_Id] = msg.sender;
    }

    function putOnSell(uint _carId, bool _is_on_sale) public {
        cars[_carId].is_selling = _is_on_sale;
        if (_is_on_sale == true) {
            on_sale_cars.push(cars[_carId]);
        }
    }

    function changePrice(uint _carId, uint newPrice) _isOwner(_carId) public {
        cars[_carId].price = newPrice;
        emit pricaChanged(_carId, msg.sender, newPrice);
    }

    function carsCount() external view returns(uint) {
        uint counter = 0;
        for (uint i = 0; i < cars.length; i++) {
            counter++;
        }
        return counter;
    }

    function isSelling(uint _Id) public view returns(bool) {
        return cars[_Id].is_selling;
    }

    // function getCarsByOwner(address _owner) external view returns(uint[] memory) {
    //     uint[] memory result = new uint[] (customer_car_count[_owner]);
    //     uint counter = 0;
    //     for (uint i = 0; i < cars.length; i++) {
    //         if (carToOwner[i] == _owner) {
    //             result[counter] = i;
    //             counter++;
    //         }
    //     }
    //     return result;
    // }

}
