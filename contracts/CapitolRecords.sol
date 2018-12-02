pragma solidity ^0.4.23;

import './AlbumERC20Registry.sol';
import './AlbumNFTRegistry.sol';

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

    function deployCapitolRecordAlbum(string _albumName, string _albumSymbol, string _albumArtist) public returns (bytes32) {
      // nft
      address nftTokenAddress = deployAlbumNFT(50000, _albumName, _albumSymbol);
      // erc20
      address erc20TokenAddress = deployAlbumERC20(_albumName, _albumSymbol, 50000000);

      bytes32 uniqueId = keccak256(abi.encodePacked(_albumName, _albumSymbol, _albumArtist));

      AlbumReference memory album = AlbumReference(uniqueId, _albumName, _albumArtist, block.timestamp, nftTokenAddress, erc20TokenAddress);

      albumById[uniqueId] = album;
      albumByNFTAddress[nftTokenAddress] = album;
      albumByERC20Address[erc20TokenAddress] = album;

      emit deployedCapitalRecordAlbum(uniqueId, nftTokenAddress, erc20TokenAddress);

      return uniqueId;
    }

    function payETHToAlbum(uint256 _amount, address erc20erc20TokenAddress) {
      // do stuff
    }
  }
