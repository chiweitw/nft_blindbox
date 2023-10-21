// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {BNFT} from "../src/BNFT.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract BNFTTest is Test {
    BNFT public bnft;
    address user;
    uint256 tokenId;
    uint256 totalSupply = 500;
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

    function mintUptoTotalSupply() public {
        for (uint256 i=0 ; i< totalSupply; i++) {
            bnft.mint();
        }
    }

    function testOpenAllBlindBoxesBefore() public {
        vm.startPrank(user);
        mintUptoTotalSupply();
        assertEq(bnft.tokenURI(123), string.concat(blindBoxBaseURI, Strings.toString(123)));
        vm.stopPrank();
    }

    function testOpenAllBlindBoxesAfter() public {
        vm.prank(user);
        mintUptoTotalSupply();
        vm.startPrank(address(bnft));
        bnft.openAllBlindBoxes();
        assertEq(bnft.tokenURI(123), string.concat(openedBlindBoxBaseURI, Strings.toString(123)));
        vm.stopPrank();
    }

    function testOpenAllBlindBoxesDeclined() public {
        vm.startPrank(user);
        mintUptoTotalSupply();
        vm.expectRevert("Only owener can open");
        bnft.openAllBlindBoxes();
        vm.stopPrank();
    }

    function testMintMoreThanTotalSupply() public {
        vm.startPrank(user);
        mintUptoTotalSupply();
        vm.expectRevert("Exceed total supply");
        bnft.mint();
        vm.stopPrank();
    }

    function testOpenAllBlindBoxedOnlyWhenReachTotalSupply() public {
        vm.startPrank(address(bnft));
        vm.expectRevert("Still have unminted boxes");
        bnft.openAllBlindBoxes();
        vm.stopPrank();
    }
}


