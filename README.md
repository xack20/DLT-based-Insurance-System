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

### 📞 Contact

For more details, reach out to the development team or check the documentation.

