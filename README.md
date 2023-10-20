# NFT and Blindbox

Implement a NFT with Blindbox mechanism

## NFT

- name: Blind NFT
- symbol: BNFT
- total supply: 500

## Blindbox mechanism

- User can mint the blind box NFTs with random and unique token IDs from 1 ~ 500
- User can only mint one blind box at a same time
- Contract owner can open all minted blind box at the same time.
- Each blind box NFT and opened blind box NFT have unique token URI
    - baseURI for Blind box NFTs: https://youdontknowme.xyz
    - baseURI for opened blind box NFTs: https://iamsorry.xyz
    - token URI (baseURI + tokenId pairs) are globally unique


## Get Started

1. Make sure you have Foundry set up. If not, you can refer to the [installation guide](https://book.getfoundry.sh/getting-started/installation).

2. Run the following command to install the required dependencies:
   ```bash
   forge install
   ```
3. Run the following command to run the tests:
   ```bash
   forge test
   ```
