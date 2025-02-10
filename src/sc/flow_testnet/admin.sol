//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

interface IERC20 {
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function balanceOf(address account) external view returns (uint256);

    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
}

contract AdminBank {
    //address private immutable MAINNET_USDC = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913;

    address private admin;
    address private immutable MOCK_USDC;

    constructor() {
        admin = 0x70ca4a44A227645BB4815AE4d68098eA68aB926F;
        MOCK_USDC = 0xe9E82211eAe28082ebD48bC80DCD534f176ecdAc;
    }

    function USDC_Transfer() external onlyAdmin {
        uint balance = IERC20(MOCK_USDC).balanceOf(address(this));
        IERC20(MOCK_USDC).transfer(admin, balance);
    }

    function USDC_Balance() external view returns (uint) {
        return IERC20(MOCK_USDC).balanceOf(address(this));
    }

    function EtherBalance() external view returns (uint) {
        return address(this).balance;
    }

    function EtherWiththdraw() external onlyAdmin {
        require(admin != address(0), "Address Zero not allowed");
        payable(admin).transfer(address(this).balance);
    }

    function AdminChange(address _admin) external onlyAdmin {
        require(_admin != address(0), "Address Zero not allowed");
        admin = _admin;
    }

    function CurrentAdmin() external view returns (address) {
        return admin;
    }

    function FundContract() external payable {}

    receive() external payable {}

    modifier onlyAdmin() {
        require(msg.sender == admin, "Admin Only Access");
        _;
    }

    //0x0000000000000000000000000000000000000000;
}
