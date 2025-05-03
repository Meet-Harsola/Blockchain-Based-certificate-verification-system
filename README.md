# Blockchain-Based-certificate-verification-system


## 🔗 Project Title
**Blockchain-Based Certificate Verification Using Ethereum Smart Contracts**

## 📚 Description
This project implements a decentralized application (DApp) for issuing and verifying certificates using Ethereum blockchain technology. It leverages smart contracts written in Solidity and provides a simple HTML interface for interaction.

## 🧩 Features
- ✅ Issue certificates with unique details
- 🔍 Verify certificate authenticity using certificate ID
- 🔐 Tamper-proof data secured on Ethereum blockchain
- 💻 Simple web-based interface to interact with the smart contract

## 🛠️ Tech Stack
- **Solidity** – Smart contract language for Ethereum
- **Ethereum** – Blockchain platform (tested on local testnet or Remix)
- **HTML/CSS** – Front-end interface
- **JavaScript (Web3.js)** – Blockchain interaction (assumed but can be added)

## 📂 Project Structure

```
├── contract.sol           # Solidity smart contract
├── miniProject.html       # Front-end for interacting with the smart contract
```

## 🚀 How to Run the Project

### ✅ Prerequisites
- [MetaMask Extension](https://metamask.io/)
- [Remix IDE](https://remix.ethereum.org/)
- A browser with Web3 support (e.g., Chrome with MetaMask)

### 🧪 Smart Contract Deployment (using Remix)
1. Open [Remix IDE](https://remix.ethereum.org/)
2. Upload `contract.sol`
3. Compile the contract
4. Deploy it using the "Deploy" button under the "Deploy & Run Transactions" tab
5. Copy the deployed contract address

### 🌐 Web Frontend Setup
1. Open `miniProject.html` in a browser
2. Update the contract address and ABI in the script (if required)
3. Connect MetaMask and select the same network used in Remix
4. Use the form to issue or verify certificates

## 🧪 Example Use Cases
- Academic institutions issuing graduation certificates
- Online courses verifying completion
- Employers verifying authenticity of credentials

## 🔒 Security Note
This project is for educational purposes. For production use:
- Perform thorough audits
- Add user authentication
- Avoid storing sensitive data directly on-chain

## ✍️ Author
Meet Harsola – M.Tech CSE, NIT Surat
