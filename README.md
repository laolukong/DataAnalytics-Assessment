# Data Analytics SQL Assessment

This repository contains SQL solutions for a SQL proficiency assessment focused on solving business problems using relational databases.

---

## 📝 Questions & Solutions

### Q1. High-Value Customers with Multiple Products
**Approach:**  
I joined the users, savings plans, and investment plans, then aggregated their deposit transactions. Customers with both plan types and at least one deposit were returned.

**Challenge:**  
Ensuring correct aggregation and filtering for distinct savings vs. investment plans.

---

### Q2. Transaction Frequency Analysis
**Approach:**  
Calculated each customer's transaction rate per month and categorized them into three tiers using a CASE statement in a CTE.

**Challenge:**  
Avoiding division by zero when tenure was 0 months; resolved using `NULLIF`.

---

### Q3. Account Inactivity Alert
**Approach:**  
Queried last transaction dates per plan, then filtered where the gap was over 365 days. Used `LEFT JOIN` to include plans with no transactions.

**Challenge:**  
Ensured fallback for completely inactive accounts (no transaction record).

---

### Q4. Customer Lifetime Value (CLV)
**Approach:**  
CLV was calculated as:  
`(total_transactions / tenure) * 12 * average_profit_per_transaction`  
Profit assumed to be 0.1% of transaction value.

**Challenge:**  
Handling customers with very short tenures and ensuring the average profit was in Naira (from Kobo).

---

## 📁 Repository Structure