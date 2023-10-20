// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract BNFT is ERC721 {
    uint256 public totalSupply;
    uint256 public baseUri;
    string public blindBoxBaseURI = "https://youdontknowme.xyz/";
    string public openedBlindBoxBaseURI = "https://iamsorry.xyz/";
    uint private counter;
    bool private opened;
    uint256[] public numbers;

    constructor() ERC721("Blind NFT", "BNFT") {
        totalSupply = 500;
        numbers = new uint256[](500);
        counter = 0;
        opened = false;
        for (uint256 i = 0; i < totalSupply; i++) {
            numbers[i] = i + 1;
        }
    }

    function mint() external {
        require(counter < totalSupply, "Exceed total supply");
        uint256 tokenId = getRandomTokenId();
        _mint(msg.sender, tokenId);
    }

    function _baseURI() internal view override returns (string memory) {
        if (opened) {
            return openedBlindBoxBaseURI;
        }

        return blindBoxBaseURI;
    }

    function openAllBlindBoxes() public {
        require(msg.sender == address(this), "Only owener can open");
        opened = true;
    }

    function getRandomTokenId() private returns (uint256) {
        uint256 i = randomNumber() % (500 - counter);
        uint256 num = numbers[i];
        counter++; 
        numbers[i] = numbers[500 - counter];

        return num;
    }

    function randomNumber() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, counter)));
    }
}



