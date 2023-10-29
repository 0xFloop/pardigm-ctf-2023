// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.0;

// import "forge-std/Test.sol";
// import "../src/hello-world/Challenge.sol";

// contract SelfDestructoor {
//     function selfDestruct(address payable _address) public {
//         selfdestruct(_address);
//     }

//     receive() external payable {}
// }

// contract ContractTest is Test {
//     Challenge challenge = Challenge(0xd6CF35c299C89f8F4cF0768481Afd961D0F7083c);
//     address target = 0x00000000219ab540356cBB839Cbe05303d7705Fa;
//     address sender = vm.addr(vm.envUint("PRIVATE_KEY"));

//     function setUp() public {
//         vm.createSelectFork(vm.rpcUrl("paradigm"));
//     }

//     function testGetSplitAddress() public {
//         challenge.SPLIT();
//     }

//     function testExploit() public {
//         vm.startPrank(sender);
//     }
// }
