// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {MyNFT} from "../src/NFT.sol";
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintMyNFT is Script {
    string public constant Star1 =
        "ipfs://bafkreiamwdsjopq76ccoydldmvvnbp4eerawrrjns4rarlp4fto5euu3l4";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MyNFT",
            block.chainid
        );
        mintNFTOnContract(mostRecentlyDeployed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        MyNFT(contractAddress).mintNFT(Star1);
        vm.stopBroadcast();
    }
}
