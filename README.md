# RentalApp

The deployment of a decentralized rental application utilizing Ethereum blockchain technology is the main focus of this project. Truffle Suite is utilized in developing the environment, testing and deploying smart contracts. Ganache is used to simulate ethereum. Depending on the accessibility, admins, owners (landlords), and tenants can carry out specific tasks in this application.<br /><br />
The main objectives include decentralization, transparency, efficiency and flexibility. Decentralization helps in eliminating intermediaries, improve transparency by recording all transactions and reduce risk associated with manipulation. Tasks that might slow down transactions and minimize human error are automated by this program. Both owners and tenants have flexibility over a number of functions.<br /><br />
Rental Application has 4 smart contracts namely, 
1. DataModel.sol has all declarations of structures and variables.<br /> 
2. GetSet.sol has functions that set and get values.<br />
3. Rental.sol has functions that are accessible by either admin, owner or tenant.<br />
4. Migration.sol ensures that each migration is only performed once by keeping track of the contracts that have been put on the blockchain.<br /><br />
*Check master branch for code.*<br />
### Steps:
1. Create a folder called rentalApp. 
2. In the directory, initiate truffle <br />command: `truffle init`
3. Migrate project <br />command: `truffle migrate`
4. `truffle console` command helps in interacting with smart contracts. This will enable a development environment.
5. The below command obtains an instance of deployed contract named rental.
The await keyword is used to wait asynchronously for deployed()'s promise to resolve
``` solidity
let instance = await Rental.deployed()
```
6. Use this instance to interact with functions.

