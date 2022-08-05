# Contracts workflow

A smart contract solution for doing our contracts feature

## Advantages

Moving the contract into smart contracts solves all the issues with centralised server like Single point of failure, cost of maintenance/running the server/limitation and cost of scaling the service for masses -- we don't have to think about system design to scale the system for contracts since that is our main feature, no intermediary needed for transactions between the buyer and seller and automation of payments between buyer and seller. Blockchain allows real-time tracking of food waste management. It helps to track the amount of food waste collected, who collected it, and where it is being moved for recycling. This tracking is very reliable since the data in blockchain is tamper-proof.

Blockchain could create a view of the waste supply chain that is accessible and visible. Blockchain, with its decentralized and tamper-proof nature, is an optimal tracking system for a product’s lifecycle, as already demonstrated in a number of industries. If it could extend through the recycling food waste process, we could increase accountability at every step rather than just placing the burden on the producer.

Using a consortium blockchain would create a platform for waste management and recycling organizations to share their data openly while having a tamper-proof ledger of where the waste actually went and what amount was recycled. This indisputable record would place accountability on every member of the chain rather than just on the producer as traditionally done, yielding a more effective recycling process. In short traceability of food waste.

Once a smart contract is deployed, it cannot be altered.

## Disadvantages

Some time would be taken around 5sec-5min and transaction cost for a smart contract to be deployed. Interacting with it also takes some time and transaction cost. Complexity is increased. No flexibility
Once a smart contract is deployed, it cannot be altered. So if any changes are to be done, new contract only should be deployed.


## Workflow

- user login using the phone number. While registering the user data, A **ethereum wallet** will be created using ethers package.

- When a user wants to create a contract between the seller, a smart contract is deployed with all the data(can be passed in the constructor) to the blockchain using ethers package.

- After that an api POST request is sent to the backend to store the contract address.

- If any data regarding the contract is needed. Using the contract address, that smart contract api can be called to get the detailed information about the contract. 

- Code the contract in such a way that the required data can be accessed from the blockchain on to the app.


## Creating a contract between the buyer and sender
Create Wallet ---> deploy smart contract ---> POST contract address

## Getting the contract info

GET contract address ---> access the smart contract in the blockchain ---> display data in the app

