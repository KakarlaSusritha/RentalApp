# RentalApp

The deployment of a decentralized rental application utilizing Ethereum blockchain technology is the main focus of this project. Truffle Suite is utilized in developing the environment, testing and deploying smart contracts. Ganache is used to simulate ethereum. Depending on the accessibility, admins, owners (landlords), and tenants can carry out specific tasks in this application.

The main objectives include decentralization, transparency, efficiency and flexibility. Decentralization helps in eliminating intermediaries, improve transparency by recording all transactions and reduce risk associated with manipulation. Tasks that might slow down transactions and minimize human error are automated by this program. Both owners and tenants have flexibility over a number of functions.

Rental Application has 4 smart contracts namely, 

1. DataModel.sol has all declarations of structures and variables. 

2. GetSet.sol has functions that set and get values.

3. Rental.sol has functions that are accessible by either admin, owner or tenant.

4. Migration.sol ensures that each migration is only performed once by keeping track of the contracts that have been put on the blockchain.
