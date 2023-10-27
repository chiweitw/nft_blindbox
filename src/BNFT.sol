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

        // make numbers become an array containing numbers from 1 to 500 in ascending order,
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
        require(counter >= totalSupply, "Still have unminted boxes");
        opened = true;
    }

    function getRandomTokenId() private returns (uint256) {
        // Random pick a index from 0 to 500 - counter
        // 1st time pick the index, 0 - 500
        // 2nd time pick the index, 0 - 499
        uint256 i = randomNumber() % (500 - counter);

        //  assign the random picked number to num for return
        uint256 num = numbers[i];

        // increment counter
        counter++; 

        // Replace the number of index with the last numbers
        // 1st time, counter = 0, last number is numbers[0]
        // 2nd time, counter = 1, last number is numbers[499] 
        numbers[i] = numbers[500 - counter];

        // return the random number
        return num;
    }

    function randomNumber() private view returns (uint256) {
        // use block.timestam and other parameters to make a temporaily random number.
        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, counter)));
    }
}



