//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract User{
    
    // enum Status {
    //     ok,
    //     notok
    // }
    
    bool public currentStatus=false;
    // constructor(){
    //     owner= (msg.sender);
        
    // }

    mapping(address=>uint256)  public allot;

    modifier onlyWhileVacant{
        require(currentStatus==false,"already Alloted");
        _;
    }

    modifier minimumCost(uint256 _amount){
        require(msg.value>_amount,"Need more than 2 ether");
        _;
    }

    modifier enterClient(address payable _client){
        require(_client!=address(0x0),"Enter Client first");
        _;
    }

    function pay(address payable   _client,uint _amount) public payable 
    onlyWhileVacant 
    minimumCost(_amount)
    enterClient(_client){
        
        if((msg.value)>=2 ether){
             currentStatus=true;
             allot[_client]=msg.value;
             //optional to use below code 
             _client.transfer(_amount);
        }

        else if((msg.value)<2 ether){
            currentStatus=false;
        }
    }
}