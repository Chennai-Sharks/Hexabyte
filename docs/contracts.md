# Contracts workflow

- user login using the phone number. While registering the user data, A **ethereum wallet** will be created using ethers package.

- When a user wants to create a contract between the seller, a smart contract is deployed with all the data(can be passed in the constructor) to the blockchain using ethers package.

- After that an api POST request is sent to the backend to store the contract address.

- If any data regarding the contract is needed. Using the contract address, that smart contract api can be called to get the detailed information about the contract. 

- Code the contract in such a way that the required data can be accessed from the blockchain on to the app.


## Creating a contract between the buyer and sender
Create Wallet ---> deploy smart contract ---> POST contract address

## Getting the contract info

GET contract address ---> access the smart contract in the blockchain ---> display data in the app

