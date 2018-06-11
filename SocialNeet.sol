pragma solidity ^0.4.24;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */

 
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    // Gas optimization: this is cheaper than asserting 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (a == 0) {
      return 0;
    }

    c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return a / b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
    c = a + b;
    assert(c >= a);
    return c;
  }
}


contract Publish {


    struct Content {
        address content_owner;
        string ipfs_content;
    }


    uint256 shares;
    
    struct Influencer{
       bool top5;
       bool shared;
       uint256 followers;
    }

    mapping(address => Influencer ) public Influencers;

    uint public ammount_raised;
    uint public ammount_;
    address public owner;
    address [] public BNS;
    mapping(address => Influencer) public Influencers;
    uint minimum_I_value;


    function publish(Content cont) public payable {
        require(msg.value != 0 );
        require();
        
    }


    function shareEvent(address _address){
      require(msg.gas >= add(gas_ammount_to_stop,gas_ammount_to_share));
      require(msg.gas >= add(gas_ammount_to_end,gas_ammount_to_share));
      require(Influencers[_address].shared != true);
      Influencers[_address].shared = true;
      minimum = get_min_inf();
      ammount_raised = ;
      if (Influencers[_address].followers > minimum[0] ){
        BNS[minimum[1]] = _address;
        Influencers[BNS[minimum[1]]].top = false;
        Influencers[_address].top5 = true;
      }

    }

    function get_min_inf(){
      uint min;
      uint min_addr;
      if(BNS.length > 1){
        min = Influencers[BNS[0]];
        for (uint i=1; i< BNS.length){
            if (Influencers[BNS[i]].followers < min){
              min = Influencers[BNS[i]].followers;
              min_addr_count = i;
            }
        }
      }
      return min,min_addr_count
    }

    function AuthorStopCollect(){
        require(msg.sender == owner);
        EachAmmount = EffortPayment();
        if(BNS.length >0){
          for (uint i=1; i< BNS.length){
              BNS[i].transfer(EachAmmount);
          }
         
        }
        socialnet_adr.transfer(div(mul(30,msg.value),100));
        selfdestruct(owner);
    }

        
    function EffortPayment() { 
                for (uint i=0 ; i < BNS.length; i++){
                }
        }
    }
    

    function UserCollect(address _address) {
          require( Influencers[_address].top5 == true)
          _address.transfer(EachAmmount);
        
    }

}


contract SocialCore {
    
    struct User {
        address adr;
        string ipns_user_profile;
        string ipns_user_post;
        address [] followers;
    }
    


    function OpenContentToCollect()
    {


    }
    
    function MaintenanceRedistribution()
    {


    }

    function GitUsersDevTeam()
    {


    }
    
}

