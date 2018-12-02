pragma solidity ^0.4.23;

import './AlbumERC20Registry.sol';
import './AlbumNFTRegistry.sol';
import './AlbumERC20.sol';

contract CapitolRecords
  is
  AlbumERC20Registry,
  AlbumNFTRegistry
  {
    event deployedCapitalRecordAlbum(bytes32 id, address nft, address erc20);

    struct AlbumReference {
      bytes32 id;
      string albumName;
      string albumArtist;
      uint256 timestamp;
      address nft; // where the non fungible token lives
      address erc20; // as an accounting tool for album ownership
    }

    mapping(address => AlbumReference) albumByERC20Address;
    mapping(address => AlbumReference) albumByNFTAddress;
    mapping(bytes32 => AlbumReference) albumById;

    AlbumReference[] albums;

    /*
      Main deployer function for creating a new tradable Album. Creating an asset out of thin air and electricity.
    */
    function deployCapitolRecordAlbum(string _albumName, string _albumSymbol, string _albumArtist) public returns (bytes32) {
      // nft (this registry will "owned" the NFT while it is being funded)
      address nftTokenAddress = deployAlbumNFT(50000, _albumName, _albumSymbol);
      // erc20
      address erc20TokenAddress = deployAlbumERC20(_albumName, _albumSymbol, 50000000);
      // hash the album name, symbol, artist name
      bytes32 uniqueId = keccak256(abi.encodePacked(_albumName, _albumSymbol, _albumArtist));
      // create the struct
      AlbumReference memory album = AlbumReference(uniqueId, _albumName, _albumArtist, block.timestamp, nftTokenAddress, erc20TokenAddress);
      // add key:value mappings
      albumById[uniqueId] = album;
      albumByNFTAddress[nftTokenAddress] = album;
      albumByERC20Address[erc20TokenAddress] = album;

      emit deployedCapitalRecordAlbum(uniqueId, nftTokenAddress, erc20TokenAddress);

      return uniqueId;
    }

    function getBalance(address account, bytes32 uniqueId) returns (uint256){
      for (uint i = 0; i < albums.length; i++) {
        if (albums[i].id == uniqueId) {
          AlbumERC20 albumErc20 = AlbumERC20(albums[i].erc20);
          return albumErc20.balanceOf(account);
        }
      }
    }

    /*
      Convenience function for the frontend to be able to call when funds are sent.
    */
    function sendETHToAlbum (bytes32 uniqueId, uint256 amount) {
      for (uint i = 0; i < albums.length; i++) {
        if (albums[i].id == uniqueId) {
          AlbumERC20 albumErc20 = AlbumERC20(albums[i].erc20);
          albumErc20.transferFrom(msg.sender, address(albumErc20), amount);
        }
      }
    }

    function distributeFundsToOwners() {

    }
  }
