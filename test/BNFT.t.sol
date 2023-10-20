// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {BNFT} from "../src/BNFT.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract BNFTTest is Test {
    BNFT public bnft;
    address user;
    uint256 tokenId;
    string public blindBoxBaseURI = "https://youdontknowme.xyz/";
    string public openedBlindBoxBaseURI = "https://iamsorry.xyz/";

    function setUp() public {
        bnft = new BNFT();
        user = makeAddr("Alice");
    }

    function testName() public {
        assertEq(bnft.name(), "Blind NFT");
    }

    function testSymbol() public {
        assertEq(bnft.symbol(), "BNFT");
    }

    function testMint() public {
        vm.startPrank(user);
        bnft.mint();
        assertEq(bnft.balanceOf(user), 1);
        vm.stopPrank();
    }

    function testBeforeOpenBlindBox() public {
        vm.startPrank(user);
        bnft.mint();
        tokenId = uint(keccak256(abi.encodePacked(address(bnft), Strings.toString(0))));
        assertEq(bnft.tokenURI(tokenId), string.concat(blindBoxBaseURI, Strings.toString(tokenId)));
        vm.stopPrank();
    }

    function testAfterOpenBlindBox() public {
        vm.prank(user);
        bnft.mint();

        vm.startPrank(address(bnft));
        bnft.openAllBlindBoxes();
        tokenId = uint(keccak256(abi.encodePacked(address(bnft), Strings.toString(0))));
        assertEq(bnft.tokenURI(tokenId), string.concat(openedBlindBoxBaseURI, Strings.toString(tokenId)));
        vm.stopPrank();
    }
}


