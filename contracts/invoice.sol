// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract InvoiceContract {
    address public owner;
    IERC20 public usdc;

    struct Invoice {
        uint256 amount;
        string description;
        bool paid;
        address recipient;
        address issuer; // New field to store the invoice creator
        string celestiaHash;
    }

    mapping(uint256 => Invoice) public invoices;

    event InvoicePaid(uint256 indexed invoiceId, uint256 amount);
    event InvoiceCreated(uint256 indexed invoiceId, uint256 amount, address recipient, address issuer);

    constructor() {
        owner = msg.sender;
        usdc = IERC20(0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913);
    }

    function addInvoice(
        uint256 invoiceId,
        uint256 amount,
        string calldata description,
        string calldata celestiaHash,
        address recipient
    ) external {
        require(invoices[invoiceId].recipient == address(0), "Invoice already exists");
        invoices[invoiceId] = Invoice(amount, description, false, recipient, msg.sender, celestiaHash);
        emit InvoiceCreated(invoiceId, amount, recipient, msg.sender);
    }

    function payInvoice(uint256 invoiceId, string calldata celestiaHash, uint256 amount) external {
        Invoice storage invoice = invoices[invoiceId];
        require(invoice.recipient != address(0), "Invoice does not exist");
        require(!invoice.paid, "Invoice already paid");
        require(amount >= invoice.amount, "Insufficient amount");

        // Transfer USDC from sender to the issuer (who created the invoice)
        require(usdc.transferFrom(msg.sender, invoice.issuer, amount), "USDC transfer failed");
        
        invoice.paid = true;
        invoice.celestiaHash = celestiaHash;
        emit InvoicePaid(invoiceId, amount);
    }
}
