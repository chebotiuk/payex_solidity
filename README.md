Here is a `README.md` file for your `InvoiceContract.sol`:

```markdown
# InvoiceContract

A Solidity smart contract for managing invoices using USDC (ERC20 token). The contract allows invoice creation, tracking, and payment while ensuring secure transactions.

## Features

- **Invoice Creation**: Users can create invoices with an amount, description, recipient, and Celestia hash for reference.
- **Invoice Payment**: Invoices can be paid using USDC, transferring funds from the payer to the invoice issuer.
- **Event Logging**: The contract emits events when invoices are created or paid.
- **Security Checks**: Prevents duplicate invoices and ensures proper fund transfers.

## Contract Details

- **Owner**: The contract deployer.
- **Token Used**: USDC (`IERC20` interface).
- **Storage**:
  - `invoices` mapping stores invoice details.
  - Each invoice includes amount, description, recipient, issuer, payment status, and a Celestia hash.

## Deployment

The contract initializes with a predefined USDC address:
```solidity
usdc = IERC20(0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913);
```
Ensure this address matches the correct USDC token on your network.

## Functions

### `addInvoice(uint256 invoiceId, uint256 amount, string calldata description, string calldata celestiaHash, address recipient)`
Creates a new invoice.

- **Requires**:
  - Invoice ID must be unique.
- **Emits**: `InvoiceCreated`

### `payInvoice(uint256 invoiceId, string calldata celestiaHash, uint256 amount)`
Pays an invoice using USDC.

- **Requires**:
  - Invoice must exist and be unpaid.
  - Amount must be sufficient.
  - USDC transfer must succeed.
- **Emits**: `InvoicePaid`

## Events

- **`InvoiceCreated(uint256 indexed invoiceId, uint256 amount, address recipient, address issuer)`**
- **`InvoicePaid(uint256 indexed invoiceId, uint256 amount)`**

## Security Considerations

- Ensure the contract is deployed on a secure Ethereum-compatible network.
- Verify the USDC address before deployment.
- Use `approve` before `payInvoice` to allow transfers.


## Environment Variables

Create a `.env` file to store sensitive information:

```
INFURA_URL=YOUR_INFURA_HTTP_ENDPOINT
INFURA_WS_URL=YOUR_INFURA_WEBSOCKET_ENDPOINT
PRIVATE_KEY=YOUR_PRIVATE_KEY
```

Make sure INFURA_URL corresponds to target network

## Deployment

To deploy this contract, follow these steps:

1. **Compile** the contract using a Solidity compiler, such as [Remix](https://remix.ethereum.org/) or Truffle.
2. **Deploy** the contract on Ethereum via Remix, Hardhat, or Truffle.
3. **Set the Heir Address** in the deployment arguments.

Simply run
`npm install` ->
`npm compile-and-deploy`

---

## Testing

This project uses `Truffle` for testing. 

### Prerequisites

- [Node.js](https://nodejs.org/)
- [Truffle](https://trufflesuite.com/docs/truffle/getting-started/installation)
- [Ganache](https://trufflesuite.com/ganache/) (optional for local testing)

### Running Tests

1. Install dependencies:
   ```bash
   npm install
   ```

2. `truffle test`
