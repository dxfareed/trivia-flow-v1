//SPDX-License-Identifier: MIT

pragma solidity >=0.8.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract flipit is ERC20 {

    //flow testnet
    //$TRIB address 0xe9E82211eAe28082ebD48bC80DCD534f176ecdAc

    address _owner_;
    //uint256 private constant dec = 1e18;
    uint256 private constant DECIMALS = 10**6;
    address contractAddress;
    error NoToken(string);
    error TokenClaimed(string);
    error AddressNotFound(string);
    address[] private _senderEth;
    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        
        _mint(address(this), 100_000 * DECIMALS);
        _owner_ = msg.sender;
        contractAddress = address(this);

    }
    function pumptit(uint256 _pumpMint) public {
        require(_owner_ == msg.sender, "Not owner!");
        _mint(msg.sender, _pumpMint * DECIMALS);
    }
    function decimals() public pure override returns(uint8){
        return 6;
    }
    function Claim(address _addrs) external {
        if (_addrs == address(0)) {
            revert AddressNotFound("Address zero not allowed!");
        }
        if (balanceOf(_addrs) > 0) {
            revert TokenClaimed("Address Claimed!");
        }
        _transfer(contractAddress, _addrs, 10_000 * DECIMALS);
    }

    function Burn(uint256 _value) external {
        if (balanceOf(msg.sender) < 0) {
            revert NoToken("Token not Enough!");
        }
        _burn(msg.sender, _value * DECIMALS);
    }

    function Balance(address _user) external view returns (uint256) {
        return balanceOf(_user);
    }
}
/* 

   ca 0xC5CaC9d5a86bB578553ee84FaeE022f8d251A9C9

*/ 
 //500000000000000000000
//0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
//me