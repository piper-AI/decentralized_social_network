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
    using SafeMath for uint256;

    struct Content {
        address content_owner;
        string ipfs_content;
    }

    uint256 public shares;
    struct Influencer{
       bool top5;
       bool shared;
       uint256 followers;
    }

    mapping(address => Influencer ) public Influencers;

    // 
    address socialnet_adr;
    uint256 public gas_ammount_to_stop;
    uint256 public gas_ammount_to_end;
    bool public finished;
    uint256[2]  public Pammount_;
    uint256 public ammount_;
    address public owner;
    address [] public BNS;
    address [] public BNS_finish;
    uint256 collected;
    // mapping(address => Influencer) public Influencers;
    uint minimum_I_value;
    
    uint256 public debug_gas;

     constructor (address _address) public payable {
        owner=msg.sender;
        ammount_ = msg.value;
        debug_gas = msg.gas;
        require(msg.value != 0 );
        finished=false;
        collected=0;
        gas_ammount_to_stop=0;
        gas_ammount_to_end=0;
        
    }

    function shareEvent  (address _address) public{
      if (msg.gas >= gas_ammount_to_stop){
          if(msg.gas >= gas_ammount_to_end){
                    uint256 [2] memory minimum;
                //   require(msg.gas >= add(gas_ammount_to_stop,gas_ammount_to_share));
                //   require(msg.gas >= add(gas_ammount_to_end,gas_ammount_to_share));
                  require(Influencers[_address].shared != true);
                  Influencers[_address].shared = true;
                  minimum = get_min_inf();
                //   ammount_raised = ;
                
                
                // Influencers Followers---> Users Followers.
                  if (Influencers[_address].followers > minimum[0] ){
                    BNS[minimum[1]] = _address;
                    Influencers[BNS[minimum[1]]].top5 = false;
                    Influencers[_address].top5 = true;
                    shares += 1;
                  }
                  
          }else {}
      }else {Finish();}
     
    }
    function Finish() public {
        
        finished=true;
        Pammount_ = EffortPayment();
        socialnet_adr.transfer(Pammount_[1]);
    }

    function get_min_inf() public returns(uint256[2] memory){
        // index
      uint min;
      uint min_addr_count;
      uint256 [2] memory minimal;
      if(BNS.length > 1){
        min = Influencers[BNS[0]].followers;
        for (uint i=1; i< BNS.length ;i++){
            if (Influencers[BNS[i]].followers < min){
              min = Influencers[BNS[i]].followers;
              min_addr_count = i;
            }
        }
        minimal[0] = min;
        minimal[1] = min_addr_count;
      }
      
      return minimal;
    }

    // function ownerCollect(address _address){
    //     require(owner==_address);
    //     owner.transfer(PAmmount[1]);
    // }

    function AuthorStopCollect() public {
        require(msg.sender == owner);
        uint256[2] memory EachAmmount;
        EachAmmount = EffortPayment();
        if(BNS.length >0){
          for (uint i=1; i< BNS.length;i++){
              BNS[i].transfer(EachAmmount[0]);
          }
         
        }
        socialnet_adr.transfer(EachAmmount[1]);
        selfdestruct(owner);
    }


    function EffortPayment() public returns(uint256 [2] memory ){ 
        // easy and boring proposal  all equals
                uint256[2] memory AmmountAll;
                uint256 AmmountSN;
                uint256 Ammount;
                AmmountAll[0]=SafeMath.div(SafeMath.div(SafeMath.mul(75,msg.value),100),BNS.length);
                AmmountAll[1]= msg.value - Ammount;
                return AmmountAll;
        }
    

    function UserCollect(address _address) public {
        require(finished=true);
        
          require( Influencers[_address].top5 == true);
          _address.transfer(Pammount_[0]);
          collected += collected;
          if(collected==BNS.length){
              selfdestruct(owner);
          }
        
    }


}

contract SocialCore {
    
    
    address socialnet_adr;
    uint256 debug_gas_sc;
    struct Follow {
        bool is_f;
    }
    
    struct User {
        string ipns_user_profile;
        string ipns_user_post;
        mapping (address => Follow) Followers;
        
    }
    mapping(address => User ) public Users;  
    
    constructor(address _addresso){
                socialnet_adr = msg.sender;
                debug_gas_sc = msg.gas;
        
    }
    
    function CreateUser(address addresu, string ipnsProf, string ipnsPost) public payable{
        Users[addresu].ipns_user_profile = ipnsProf;
        Users[addresu].ipns_user_post = ipnsPost;
        
    }


    function AddFollowerFS(address addressu,address addressf) public 
    {
        Users[addressu].Followers[addressf].is_f=true;
    }



    // function OpenContentToCollect()
    // {


    // }
    
    // function MaintenanceRedistribution()
    // {


    // }

    // function GitUsersDevTeam()
    // {
    //# QualityCommits


    // }
    
}
