pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Metadata.sol";

contract AlbumNFT is ERC721Metadata, Ownable {
  constructor (
    string _name,
    string _symbol
    )
    public
    ERC721Metadata(_name, _symbol)
    Ownable()
    {
    }
}
