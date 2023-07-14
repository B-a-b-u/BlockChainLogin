// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

contract Register {
    
    // Structure to Store User Data
    struct userData {
        string name;
        string username;
        string password;
        bool isLoggedIn;
    }

    // Mapping address to userData
    mapping (address => userData) userRecord;

    // Events
    // Event for Registration
    event userRegister(address indexed userAddress,string username);

    // Creating a Dynamic Array of Structures
    userData[] public  userdata;

    // Conditions
    // UserName should not be empty
    modifier registerConditions(string memory _name,string memory _username,string memory _password) {
        require(bytes(_name).length > 0,"Name Should Not Be Empty");
        require(bytes(_username).length > 0,"User Name Should Not Be Empty");
        require(bytes(_password).length > 0,"Password Should Not Be Empty");
        _;
    }

    // Check Login
    modifier checkLoginStatus(){
        require(userRecord[msg.sender].isLoggedIn == false,"You are Already Logged In...");
        _;
    }

    // Function for Register new user
    function registerUser(string memory _name,string memory _username,string memory _password) external registerConditions(_name,_username,_password) checkLoginStatus returns (string memory) {
        userData memory data = userData(_name,_username,_password,false);
        userdata.push(data);
        userRecord[msg.sender] = data;
        emit userRegister(msg.sender,_username);
        return "Data Stored Successfully";
    }

    // Function to Display Current User Registered Details
    function displayRegisterdUsers() external view returns(string memory,string memory,string memory,bool ) {
        userData memory obj = userRecord[msg.sender];
        return (obj.name,obj.username,obj.password,obj.isLoggedIn);
    }
}