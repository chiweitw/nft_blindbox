// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BNFT is ERC721 {
    uint256 public totalSupply;
    string public blindBoxBaseURI = "https://youdontknowme.xyz/";
    string public openedBlindBoxBaseURI = "https://iamsorry.xyz/";
    uint private counter;

    constructor() ERC721("Blind NFT", "BNFT") {
        totalSupply = 500;
        counter = 0;
        baseUri = blindBoxBaseURI;
    }

    function mint() external {
        require(counter < totalSupply, "Exceed total supply");

        uint tokenID = uint(keccak256(abi.encodePacked(msg.sender, counter)));
        counter++; 

        _mint(msg.sender, tokenId);
    }

    function openAllBlindBoxes() public {
        require(msg.sender == address(this), "Only owener can open");

        _setBaseURI(openedBlindBoxBaseURI);
    }
}



