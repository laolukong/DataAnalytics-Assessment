-- Assessment_Q2.sql

-- Categorize customers based on average monthly transactions
WITH transaction_counts AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        DATEDIFF(MAX(transaction_date), MIN(transaction_date)) / 30.0 AS tenure_months
    FROM savings_savingsaccount
    GROUP BY owner_id
),
categorized AS (
    SELECT 
        owner_id,
        total_transactions,
        tenure_months,
        (total_transactions / NULLIF(tenure_months, 0)) AS avg_tx_per_month,
        CASE 
            WHEN (total_transactions / NULLIF(tenure_months, 0)) >= 10 THEN 'High Frequency'
            WHEN (total_transactions / NULLIF(tenure_months, 0)) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM transaction_counts
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tx_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category;