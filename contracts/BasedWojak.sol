// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract BasedWojak is ERC1155, Ownable, ERC1155Supply {
    uint256 public maxSupply = 10000;

    constructor()
        ERC1155("ipfs://QmcHqFtyu46BwHNRfcx9mtCnbiT2jR37K6m2upLE2EBMAC/")
    {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
    // add supply tracking
    function mint(uint256 id, uint256 amount)
        public
    {
        require(id < 1);
        require(totalSupply(id) + amount < maxSupply );
        _mint(msg.sender, id, amount, "");
    }

    function uri(uint256 _id) public view virtual override returns (string memory) {
        require(exists(_id), "URI: non: nonexistent token");

        return string(abi.encodePacked(super.uri(_id), Strings.toString(_id), ".json"));
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}