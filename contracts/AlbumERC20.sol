pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";

contract AlbumERC20 is ERC20, ERC20Detailed {
  uint256 _totalSupply;
  mapping (address => uint256) private _balances;

  constructor (
    string name,
    string symbol,
    uint8 decimals,
    uint256 initialSupply
  )
  ERC20()
  ERC20Detailed(name, symbol, decimals)
  public
  {
    _totalSupply = initialSupply;
	  _balances[tx.origin] = _totalSupply;
  }
}
