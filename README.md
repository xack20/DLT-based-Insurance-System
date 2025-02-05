# Insurance System Flows

This document outlines the various flows within the insurance system, including policy verification, claims submission, and policy issuance using blockchain technology.

## Table of Contents
1. [Policyholder Views Policy Status, Claim History, and ID Verification](#policyholder-views-policy-status-claim-history-and-id-verification)
2. [QR Code Scanning for Quick Verification at Hospitals](#qr-code-scanning-for-quick-verification-at-hospitals)
3. [Hospitals Verify Policyholder Status via Web-Based Dashboard](#hospitals-verify-policyholder-status-via-web-based-dashboard)
4. [Policy Issuance via Smart Contract](#policy-issuance-via-smart-contract)
5. [Claims Submission and Approval](#claims-submission-and-approval)
6. [Premium Payment and Policy Activation](#premium-payment-and-policy-activation)

---

## 1. Policyholder Views Policy Status, Claim History, and ID Verification

1. **Policyholder logs into the Policyholder Portal using MFA.**
2. Policyholder Portal sends a request to the Backend System to fetch policy status, claim history, and ID verification details.
3. Backend System retrieves policy status and claim history from the encrypted database.
4. Backend System retrieves ID verification details from IPFS/cloud storage.
5. Backend System returns the data to the Policyholder Portal.
6. Policyholder Portal displays the data to the Policyholder.

---

## 2. QR Code Scanning for Quick Verification at Hospitals

1. **Policyholder presents a QR code at the hospital.**
2. Hospital Staff scans the QR code using the Provider Portal.
3. Provider Portal sends a verification request to the Backend System.
4. Backend System queries the Blockchain (Policy Verification Contract) for policyholder status.
5. Blockchain returns the verification result to the Backend System.
6. Backend System sends the result to the Provider Portal.
7. Provider Portal displays the verification status to the Hospital Staff.

---

## 3. Hospitals Verify Policyholder Status via Web-Based Dashboard

1. **Hospital Staff logs into the Provider Portal using MFA.**
2. Hospital Staff enters the policyholder’s details (e.g., policy number or ID).
3. Provider Portal sends a verification request to the Backend System.
4. Backend System queries the Blockchain (Policy Verification Contract) for policyholder status.
5. Blockchain returns the verification result to the Backend System.
6. Backend System sends the result to the Provider Portal.
7. Provider Portal displays the verification status to the Hospital Staff.

---

## 4. Policy Issuance via Smart Contract

1. **Admin creates a new policy for a policyholder.**
2. Backend System sends policy details to the Blockchain (Policy Issuance Contract).
3. Blockchain records the policy details and generates a tokenized membership card.
4. Blockchain returns the policy ID and tokenized membership card to the Backend System.
5. Backend System stores the policy details in the encrypted database.
6. Backend System sends a confirmation to the Admin.

---

## 5. Claims Submission and Approval

1. **Policyholder logs into the Policyholder Portal using MFA.**
2. Policyholder submits a claim with supporting documents.
3. Policyholder Portal sends the claim details to the Backend System.
4. Backend System stores the claim details in the encrypted database.
5. Backend System sends the claim details to the Blockchain (Claims Management Contract).
6. Blockchain records the claim and triggers an approval process.
7. Blockchain returns the claim status to the Backend System.
8. Backend System sends the claim status to the Policyholder Portal.
9. Policyholder Portal displays the claim status to the Policyholder.

---

## 6. Premium Payment and Policy Activation

1. **Policyholder initiates a premium payment via the Policyholder Portal.**
2. Policyholder Portal redirects the Policyholder to the Payment Gateway (Stripe).
3. Policyholder completes the payment on Stripe.
4. Stripe sends a payment confirmation to the Backend System.
5. Backend System updates the Blockchain (Policy Issuance Contract) with the payment details.
6. Blockchain activates the policy and returns the updated status to the Backend System.
7. Backend System stores the updated policy status in the encrypted database.
8. Backend System sends a confirmation to the Policyholder Portal.
9. Policyholder Portal displays the updated policy status to the Policyholder.

---

### 🛠 Technologies Used

- **Frontend:** Web-based portals for Policyholders and Providers
- **Backend:** Secure API for data handling
- **Blockchain:** Smart Contracts for Policy Issuance and Claims Management
- **Database:** Encrypted storage for policy and claims data
- **Authentication:** Multi-Factor Authentication (MFA)
- **IPFS/Cloud:** Secure storage for ID verification

---

### 📌 Notes

- The system ensures security and privacy using encrypted databases and blockchain verification.
- Smart contracts automate policy issuance, claims processing, and verification.
- MFA is enforced to prevent unauthorized access.

---



# Hyperledger Fabric Network Architecture for Insurance System

This document outlines the **Hyperledger Fabric network architecture** and its components for the insurance system. The architecture is designed to ensure **security**, **scalability**, and **confidentiality** while meeting the unique requirements of the insurance industry.

---

## Key Components

### 1. Organizations
Organizations represent the entities participating in the network. For this project, the following organizations are relevant:

- **InsuranceOrg**: The insurance company issuing policies and managing claims.
- **HospitalOrg**: Hospitals and clinics verifying policyholder status and submitting claims.
- **RegulatorOrg** (Optional): Regulators for auditing and compliance.

Each organization has its own **Membership Service Provider (MSP)** to manage identities and permissions.

---

### 2. Peer Nodes
Peer nodes host the ledger and chaincode (smart contracts). Each organization can have one or more peers:

- **InsuranceOrg Peers**:
  - **Endorsing Peers**: Execute chaincode for policy issuance, verification, and claims management.
  - **Committing Peers**: Maintain the ledger for all transactions.
  - **Anchor Peers**: Facilitate communication with other organizations.

- **HospitalOrg Peers**:
  - **Endorsing Peers**: Execute chaincode for policy verification and claims submission.
  - **Committing Peers**: Maintain a copy of the ledger relevant to their transactions.

- **RegulatorOrg Peers** (Optional):
  - **Committing Peers**: Maintain a read-only copy of the ledger for auditing purposes.

---

### 3. Certificate Authorities (CA)
Each organization has its own **Certificate Authority (CA)** to issue certificates for identity management:

- **InsuranceOrg CA**: Issues certificates for InsuranceOrg members.
- **HospitalOrg CA**: Issues certificates for HospitalOrg members.
- **RegulatorOrg CA** (Optional): Issues certificates for RegulatorOrg members.

CAs ensure that only authorized participants can join the network and perform transactions.

---

### 4. Orderer Nodes
Orderer nodes are responsible for **transaction ordering** and **consensus**. They ensure that all transactions are added to the ledger in the correct order.

- **Orderer Service**: A cluster of orderer nodes using a **crash fault-tolerant (CFT)** consensus algorithm (e.g., Raft).
- **Orderer Organizations**: Typically managed by a consortium of organizations or a neutral third party.

---

### 5. Channels
Channels are private sub-networks within the blockchain that allow confidential transactions between specific organizations:

- **PolicyChannel**: For transactions between **InsuranceOrg** and **HospitalOrg** (e.g., policy issuance, verification, and claims).
- **AuditChannel** (Optional): For transactions involving **RegulatorOrg** (e.g., auditing and compliance).

Each channel has its own ledger, and only the organizations participating in the channel can access its data.

---

### 6. Chaincode (Smart Contracts)
Chaincode implements the business logic of the insurance system. The following chaincodes are required:

- **PolicyIssuanceChaincode**: Manages policy creation and updates.
- **PolicyVerificationChaincode**: Handles real-time verification requests.
- **ClaimsManagementChaincode**: Tracks claims submission and approval.

Chaincode is installed on the endorsing peers of the relevant organizations and instantiated on the channels.

---

### 7. Off-Chain Components
- **Encrypted Database**: Stores sensitive data like personal details, claims history, and medical records.
- **IPFS/Cloud Storage**: Stores policy documents and ID verification files.
- **APIs**:
  - **Blockchain API**: Connects the frontend and backend to the blockchain network.
  - **Provider API**: Integrates with hospitals/clinics for verification.
  - **Payment Gateway API**: Links premium payments to blockchain records.

---

## Network Architecture Diagram

```plaintext
+-------------------+       +-------------------+       +-------------------+
| InsuranceOrg      |       | HospitalOrg       |       | RegulatorOrg      |
| (Insurance Company)|       | (Hospitals/Clinics)|       | (Optional)        |
+-------------------+       +-------------------+       +-------------------+
        |                           |                           |
        |                           |                           |
        v                           v                           v
+-------------------+       +-------------------+       +-------------------+
| InsuranceOrg CA   |       | HospitalOrg CA    |       | RegulatorOrg CA   |
+-------------------+       +-------------------+       +-------------------+
        |                           |                           |
        |                           |                           |
        v                           v                           v
+-------------------+       +-------------------+       +-------------------+
| InsuranceOrg Peers|       | HospitalOrg Peers |       | RegulatorOrg Peers|
| - Endorsing       |       | - Endorsing       |       | - Committing      |
| - Committing      |       | - Committing      |       | (Read-Only)       |
| - Anchor          |       | - Anchor          |       +-------------------+
+-------------------+       +-------------------+
        |                           |
        |                           |
        v                           v
+---------------------------------------------------------------+
| Orderer Service                                                |
| - Orderer Nodes (Raft Consensus)                               |
+---------------------------------------------------------------+
        |                           |
        |                           |
        v                           v
+-------------------+       +-------------------+
| PolicyChannel     |       | AuditChannel      |
| (InsuranceOrg &   |       | (InsuranceOrg &   |
| HospitalOrg)      |       | RegulatorOrg)     |
+-------------------+       +-------------------+
        |                           |
        |                           |
        v                           v
+-------------------+       +-------------------+
| Off-Chain Storage |       | Off-Chain Storage |
| - Encrypted DB    |       | - IPFS/Cloud      |
+-------------------+       +-------------------+



### 📞 Contact

For more details, reach out to the development team or check the documentation.

