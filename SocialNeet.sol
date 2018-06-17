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



contract Publish{
    using SafeMath for uint256;

    uint256 public shares;
    struct Influencer{
       bool top5;
       bool shared;
       uint256 followers;
    }

    mapping(address => Influencer ) public Influencers;

    // 
    string ipfs_content;
    SocialCore score;
    address socialnet_adr;
    uint256 public gas_ammount_to_stop;
    uint256 public gas_ammount_to_end;
    bool public finished;
    uint256[2]  public Pammount_;
    uint256 public ammount_;
    address public owner;
    address [] public BNS;
    // address [2] public BNS_finish;
    uint256 public collected;
    // mapping(address => Influencer) public Influencers;
    uint minimum_I_value;
    
    uint256 public debug_gas;

     constructor (string ipfs_content1, SocialCore socialcore) public payable {
        score = socialcore;
        socialnet_adr=score.OwnerIs();
        owner=msg.sender;
        ammount_ = msg.value;
        debug_gas = gasleft();
        ipfs_content = ipfs_content1;
        finished=false;
        collected=0;
        gas_ammount_to_stop=0;
        gas_ammount_to_end=0;
        score.CreatePublish(owner,this);
        BNS.length = 2;

    }

    // function shareEvent() public{
    //     //       if (gasleft() >= gas_ammount_to_stop){
    //     //   if(gasleft() >= gas_ammount_to_end){
    
    //   if (true){
    //       if(true){
    //                 uint256 [2] memory minimum;
    //             //   require(msg.gas >= add(gas_ammount_to_stop,gas_ammount_to_share));
    //             //   require(msg.gas >= add(gas_ammount_to_end,gas_ammount_to_share));
    //               require(Influencers[msg.sender].shared != true);
    //               Influencers[msg.sender].shared = true;
    //               shares += 1;
    //               minimum = get_min_inf();
    //             //   ammount_raised = ;
    //             // Influencers Friends ---> Users Friends.
    //               if (score.getUsercount(msg.sender) > minimum[0] ){
    //                 BNS[minimum[1]] = msg.sender;
    //                 Influencers[BNS[minimum[1]]].top5 = false;
    //                 Influencers[msg.sender].top5 = true;
    //               }
                  
    //       }else {}
    //   }else {Finish();}
     
    // }
    
    function shareEvent() public{
                uint256 [2] memory minimum;
                require(Influencers[msg.sender].shared != true);
                Influencers[msg.sender].shared = true;
                shares += 1;
                minimum = get_min_inf();
                //   ammount_raised = ;
                // Influencers Friends ---> Users Friends.
                if (score.getUsercount(msg.sender) > minimum[0]  ||  BNS[minimum[1]]==address(0x0)){
                    Influencers[BNS[minimum[1]]].top5 = false;
                    BNS[minimum[1]] = msg.sender;
                    Influencers[msg.sender].top5 = true;
                }
        if (shares>=2){Finish();}
    }
    
    function Finish() public {
        finished=true;
        Pammount_ = EffortPayment();
        // socialnet_adr.transfer(Pammount_[1]);
        //CallSocialToTransfer.
    }

    function get_min_inf() public view returns(uint256[2] memory){
        // index
      uint min;
      uint min_addr_count;
      uint256 [2] memory minimal;
        min = score.getUsercount(BNS[0]);
        for (uint i=0; i< BNS.length ;i++){
            if(BNS[i]==address(0x0)){
                        minimal[0] = min;
                         minimal[1] = min_addr_count;
                return minimal;
            }else{
            if (score.getUsercount(BNS[i]) < min || BNS[i]==address(0x0)){
              min = score.getUsercount(BNS[i]);
              min_addr_count = i;
            }}
        }
        minimal[0] = min;
        minimal[1] = min_addr_count;
      
    //         if(BNS.length > 1){
    //       score.getUsercount(BNS[0])
    //     min = Influencers[BNS[0]].followers;
    //     for (uint i=1; i< BNS.length ;i++){
    //         if (Influencers[BNS[i]].followers < min){
    //           min = Influencers[BNS[i]].followers;
    //           min_addr_count = i;
    //         }
    //     }
    //     minimal[0] = min;
    //     minimal[1] = min_addr_count;
    //   }
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

    function EffortPayment() public view returns(uint256 [2] memory ){ 
        // easy and boring proposal  all equals
                uint256[2] memory AmmountAll;
                uint256 Ammount;
                AmmountAll[0]=SafeMath.div(SafeMath.div(SafeMath.mul(75,ammount_),100),BNS.length);
                AmmountAll[1]= ammount_- Ammount;
                return AmmountAll;
        }
    
    function UserCollect() public {
        require(finished=true);
        if (socialnet_adr==msg.sender){
            socialnet_adr.transfer(Pammount_[1]);
            collected += 1;
        }else{
            require( Influencers[msg.sender].top5 == true);
          msg.sender.transfer(Pammount_[0]);
          collected += 1;
        }
         if(collected==BNS.length){
              selfdestruct(owner);
          }
          
        
    }


}

contract User {
    bool public ishere;
    string public name;
    string private ipfs_hash;
    address public owner;
    address[] public Friends;
    
    constructor (string name1,string ipfs_hash1, SocialCore Score) public payable {

        owner = msg.sender;
        name = name1;
        ipfs_hash = ipfs_hash1;
        ishere = true;
        Score.CreateUser(msg.sender,this) ;
    }
    
    function  AddFriends(address addressf)public {Friends.push(addressf);}
    
}


contract SocialCore {
    address public sc_owner;
    uint256 public debug_gas_sc;
    mapping (address => UserP) public Users;
    
    struct UserP {
        User Useradd;
        address[] Publish;
        uint256 counter;
    }
    constructor() public payable
    {
                sc_owner = msg.sender;
                debug_gas_sc = gasleft();
    }
    
    function OwnerIs() public view  returns(address) {
        //require is registered  
        return sc_owner;
    }
    function AddFriendsS(address addressf) public 
    {
        Users[msg.sender].Useradd.AddFriends(addressf);
        Users[msg.sender].counter += 1;
    }
    
    function  CreateUser(address user, User contractuser) public {
        Users[user].Useradd = contractuser;
    }
    
    function CreatePublish(address useradd, address publishadd) public {
        // address Pub = new Publish(ipfs,sc_owner,this);
        Users[useradd].Publish.push(publishadd);
    }
    
    function getUsercount(address useradd) public view returns(uint256) {
        return Users[useradd].counter;
    }
    function getPublishUser() public view returns(address){
        return Users[msg.sender].Publish[0];
    }
    
}

