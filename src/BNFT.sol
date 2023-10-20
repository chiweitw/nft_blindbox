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

    constructor() ERC721("Blind NFT", "BNFT") {
        totalSupply = 500;
        counter = 0;
        opened = false;
    }

    function mint() external {
        require(counter < totalSupply, "Exceed total supply");

        uint tokenID = uint(keccak256(abi.encodePacked(address(this), Strings.toString(counter))));

        _mint(msg.sender, tokenID);
        counter++; 

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
}



