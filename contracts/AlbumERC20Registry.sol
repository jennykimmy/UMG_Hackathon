pragma solidity ^0.4.23;

import './AlbumERC20.sol';

contract AlbumERC20Registry {
  function deployAlbumERC20(
    string _albumName,
    string _albumSymbol,
    uint256 _initialSupply
    )
    public
    returns (address)
    {
      // instantiate a new album erc20
      AlbumERC20 albumToken = new AlbumERC20(_albumName, _albumSymbol, 8, _initialSupply);

      // on instantiation ownership defaults to this registry. So transfer it to the person calling deploy
      albumToken.transfer(tx.origin, albumToken.totalSupply());

      return address(albumToken);
    }
}
