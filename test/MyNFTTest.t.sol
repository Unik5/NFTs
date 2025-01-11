//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {MyNFT} from "../src/NFT.sol";
import {DeployNFT} from "../script/DeployNFT.s.sol";

contract MyNFTTest is Test {
    DeployNFT public deployNFT;
    MyNFT public myNft;
    address public USER = makeAddr("user");
    string public constant Star1 =
        "ipfs://bafkreiamwdsjopq76ccoydldmvvnbp4eerawrrjns4rarlp4fto5euu3l4";

    function setUp() public {
        deployNFT = new DeployNFT();
        myNft = deployNFT.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Night Shots";
        string memory actualName = myNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        myNft.mintNFT(Star1);
        assert(myNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(Star1)) ==
                keccak256(abi.encodePacked(myNft.tokenURI(0)))
        );
    }
}
