// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract Todos {

    struct Todo {         // created a strcut has
        string text;      // one string to store the task and
        bool completed;   // one bool to show whether make done the task or not
    }

    Todo[] public todos;  // aarray to store tasks in the 'Todo' structure

    function create(string calldata _text) public {  // function to create new task type of 'Todo' structure
        todos.push(Todo(_text, false));
    }
    
    // function below is inside comment because system can make this automaticly
    
    // function get(uint _index) public view returns (string memory text, bool completed) {
    //     Todo storage todo = todos[_index];
    //     return (todo.text, todo.completed);
    // }

    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];  // create new variable ,which type of Todo, and store it inside the 'todos' array according to index
        todo.text = _text;  // add the task into the 'todo' variable
    }

    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];  // create new variable ,which type of Todo, and store it inside the 'todos' array according to index
        todo.completed = !todo.completed;  // change the bool which is show the state of task

    }
}
