// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// import "./ownable.sol";
import "./safemath.sol";
// import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/structs/EnumerableSet.sol";

contract car_production{

    using SafeMath for uint256;
    // using EnumerableSet for EnumerableSet.UintSet;
    // EnumerableSet.UintSet private myUintSet;

    address ownerAddress;

    event carAdded(uint carId, address indexed owner);

    event carSold(
        uint carId,
        address indexed newOwner,
        address indexed previousOwner,
        uint price
    );

    event priceChanged(
        uint carId,
        address indexed owner,
        uint previousPrice,
        uint newPrice
    );

    event statusChanced(uint carId, bool onSale);

    // It is used to generate id for new cars.
    uint carId;

    struct Car {
        string brand; // Brand of car
        uint price; // Price of car
        bool is_second_hand; // Status of car
    }

    Car[] onSaleCars;
    Car[] public cars;
    // add(uintSet storage myUintSet, uint256 5);

    // Mapping from car"s Id to owner address
    mapping(uint => address) public carToOwner;
    // Mapping from owner address to amount of owner`s car
    mapping(address => uint) public customerCarCount;
    // Mapping from car`s Id to sales status of car
    mapping(uint => bool) public isSelling;

    constructor() {
        ownerAddress = msg.sender;
    }

    // Checking for being sure it is owner
    modifier _isOwner(uint _car_Id) {
        require(carToOwner[_car_Id] == msg.sender, "You are not the owner of this car!");
        _;
    }

    // Add car ,which create by user, to cars array
    function addYourCar(string memory _brand, uint _price) public {
        cars.push(Car(_brand, _price, false)); // This car created now so is_second_hand status set to false.
        onSaleCars.push(cars[carId]);
        carToOwner[carId] = msg.sender;
        isSelling[carId] = true;
        carId = carId.add(1);
        customerCarCount[msg.sender] = customerCarCount[msg.sender].add(1);
        emit carAdded(carId, msg.sender);
    }

    // Change the car`s owner by car`s Id
    function buyCar(uint _Id) public {
        require(carToOwner[_Id] != msg.sender, "You are already owner of this car.");
        require(isSelling[_Id], "This car is not selling!");
        cars[_Id].is_second_hand = true;  // After buying the car it is going to be second hand.
        address previous_owner = carToOwner[_Id]; // For be able to emit the previous owner
        carToOwner[_Id] = msg.sender;
        customerCarCount[msg.sender] = customerCarCount[msg.sender].add(1);
        customerCarCount[previous_owner] = customerCarCount[previous_owner].sub(1);
        emit carSold(_Id, msg.sender, previous_owner, cars[_Id].price);
    }

    // Change the sales status of car by car`s Id
    function changeSalesStatus(uint _Id, bool _is_on_sale) _isOwner(_Id) public {
        require(isSelling[_Id] != _is_on_sale, "Your car`s already like you want."); // To avoid the unnecessary gas consumption.
        isSelling[_Id] = _is_on_sale;
        if (_is_on_sale == true) {
            onSaleCars.push(cars[_Id]);
        } else if (_is_on_sale == false) {
            delete onSaleCars[_Id];
        }
        emit statusChanced(_Id, _is_on_sale);
    }

    // Change the car`s price.
    function changePrice(uint _Id, uint _new_price) _isOwner(_Id) public {
        uint previous_price = cars[_Id].price; // For be able to emit the previous price
        cars[_Id].price = _new_price;
        emit priceChanged(_Id, msg.sender, previous_price, _new_price);
    }

    // Show how many cars exist.
    function carsCount() external view returns(uint) {
        return cars.length; // Also can be use carId + 1
    }

    // Liste yerine front-end de kullanabilmek icin enumerableSet.uintSet
}
