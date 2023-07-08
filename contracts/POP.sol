// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC1155";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract POP is ERC1155, ERC1155Burnable, Ownable {

    uint256 public constant POP_BRONZE = 0;
    uint256 public constant POP_SILVER = 1;
    uint256 public constant POP_GOLD = 2;

    string public contractURI;

    constructor(string memory _contractURI) ERC1155(_contractURI) {
        contractURI = _contractURI;

        _mint(msg.sender, POP_BRONZE, 100, "");
        _mint(msg.sender, POP_SILVER, 25, "");
        _mint(msg.sender, POP_GOLD, 10, "");
    }

    function airdrop(uint256 _tokenId, address[] calldata recipients) external onlyOwner {
        for (uint256 i = 0; i < recipients.length; i++) {
            _safeTransferFrom(msg.sender, recipients[i], _tokenId, 1, "");
        }
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override {
        super._beforeTokenTransfer(operator, from, to, ids, amount, data);
        require(
            msg.sender == owner() || to == address(),
            "Token cannot be transferred, only burned"
        );
    }


    function uri(uint256 _tokenId) public pure override returns (string memory) {
        return string(abi.encodePacked("ipfs://QmcyEvXcautKftdeVrYhHLjRrHKbyR4q7cx4vtrouPnzBa/", Strings.toString(_tokenId)));
    }

    function setContractURI(string calldata _contractURI) public onlyOwner {
        contractURI = _contractURI;
    }
}