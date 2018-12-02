pragma solidity ^0.4.23;

import './AlbumNFT.sol';

contract AlbumNFTRegistry {
  function deployAlbumNFT(
    uint256 sharesOutstanding,
    string _albumName,
    string _albumSymbol
    )
    public
    returns (address)
    {
      // instantiate a new album erc721
      AlbumNFT albumNft = new AlbumNFT(_albumName, _albumSymbol);

      return address(albumNft);
    }

}
