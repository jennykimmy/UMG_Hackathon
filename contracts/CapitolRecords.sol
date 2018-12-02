pragma solidity ^0.4.23;

import './AlbumERC20Registry.sol';
import './AlbumNFTRegistry.sol';

contract CapitolRecords
  is
  AlbumERC20Registry,
  AlbumNFTRegistry
  {
    event deployedCapitalRecordAlbum(bytes32 id);

    struct AlbumReference {
      bytes32 id;
      string albumName;
      string albumArtist;
      string timestamp;
      address nft; // where the non fungible token lives
      address erc20; // as an accounting tool for album ownership
    }

    mapping(bytes32 => AlbumReference) references;

    function deployCapitolRecordAlbum(string _albumName, string _albumSymbol, string _albumArtist) public {
      // nft
      address nftTokenAddress = deployAlbumNFT(50000, _albumName, _albumSymbol);
      // erc20
      address erc20TokenAddress = deployAlbumERC20(_albumName, _albumSymbol, 50000000);

      bytes32 uniqueId = keccak256(abi.encodePacked(_albumName, _albumSymbol, _albumArtist));

      AlbumReference storage album = AlbumReference(uniqueId, nftTokenAddress, erc20TokenAddress, _albumName, _albumArtist, block.timestamp);

      references[uniqueId] = album;

      emit deployedCapitalRecordAlbum(uniqueId);

      return uniqueId;
    }

    function payEthToAlbum() {

    }
  }
