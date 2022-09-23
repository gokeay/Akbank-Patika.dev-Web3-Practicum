// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./safemath.sol";

library CarGalery {

    function changeName() public pure {

    }

    function putOnSale() public {

    }

    function changePrice() public {

    }
}

contract car_production {

    using SafeMath for uint256;

    address ownerAddress;
    //uint customer_count = 1;

    struct Car {
        string brand;
        uint price;
        bool isSecondHand;
        bool is_selling;
    }

    // struct Customer {
    //     string name;
    //     address adres;
    // } .. gerek yok buna

    Car[] on_sale_cars;
    Car[] public cars;  //==> her araba kendi numarasina numarasi da markasina bagli oldugu icin ekstradan bir listede toplamaya gerek yok.
    // Customer[] public customers; //==> yine ayni sekiled, bu toplam isimleri vs daha farkli alicam ileride, boyle gereksiz gas harcamasina gerek yok.

    mapping(uint => address) carToOwner;
    mapping(address => uint) customer_car_count;
    //mapping(address => bool) public is_registered; //bunu modifier ekleyerek hallettim 
    //mapping(string => mapping(uint => bool)) public is_there_car; // bunu da yine modifier ile hallettim
    //mapping(uint => address) carToOwner;         //mapping(Car => address) carToOwner; // boyle bir sey olur mu?
    //mapping(address => uint) customer_Id;
    
    constructor() {
        ownerAddress = msg.sender;
    }

    modifier _is_there(uint _car_Id) {
        require(cars[_car_Id], "Car already joined the chain!");
        _;
    }

    modifier _isRightOwner(uint _car_Id) {
        require(carToOwner[_car_Id] == msg.sender, "You are not the owner of this car!");
        _;
    }

    // function register(string memory _name ) public {
    //     //customers.push(Customer(_name, _address)); // bunu cikardim, bunu mapping ile halledicem
    //     customer_Id[msg.sender] = customer_count;
    //     customer_count = customer_count.add(1);
    //     // Customer memory customer;
    //     // customer.name = _name;
    //     // customer.adres = _adres;
    //     // users.push(customer);
    // }

    function createCar(string memory _brand, uint _price) public {
        uint carId = cars.push(Car(_brand, _price, false, false)) - 1;
        carToOwner[carId] = msg.sender;
        customer_car_count[msg.sender] = customer_car_count[msg.sender].add(1);

        //customer_Id[msg.sender] = customer_Id[msg.sender].add(1);
        // Car memory car;
        // car.brand = _brand;
        // car.price = _price;
        // car.owner = _owner;
        // car.isSecondHand = _isSecondHand;
    }

    function buy_car(uint _Id ) public {
        carToOwner[cars[_Id]] = msg.sender;
        customer_car_count(msg.sender)++;
    }

    function putOnSale(uint _car_Id) _is_there(_car_Id) _isRightOwner(_car_Id) public {
        on_sale_cars.push(cars[_car_Id]);
        on_sale_cars[_car_Id].is_selling = true;
    }

    function changePrice() public {

    }
    
    // modifier _is_registered(address _adres) {
    //     require(is_registered[_adres] = 0;, "Costumer already joined the chain!");
    //     _;
    // }  // cikardim bunu da, musteri kaydetmeye gerek yok. adresleri var zaten.

}