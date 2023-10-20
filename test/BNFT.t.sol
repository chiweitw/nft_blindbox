// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {BNFT} from "../src/BNFT.sol";

contract BNFTTest is Test {
    BNFT public bnft;
    address user;

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
}
