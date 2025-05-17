-- Assessment_Q4.sql

-- Estimate Customer Lifetime Value (CLV)
WITH transactions_per_customer AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_value
    FROM savings_savingsaccount
    GROUP BY owner_id
),
customer_info AS (
    SELECT 
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
),
clv_estimates AS (
    SELECT 
        ci.customer_id,
        ci.name,
        ci.tenure_months,
        tpc.total_transactions,
        ROUND(
            (tpc.total_transactions / NULLIF(ci.tenure_months, 0)) * 12 * ((tpc.total_value / tpc.total_transactions) * 0.001) / 100,
            2
        ) AS estimated_clv
    FROM customer_info ci
    JOIN transactions_per_customer tpc ON ci.customer_id = tpc.owner_id
)
SELECT *
FROM clv_estimates
ORDER BY estimated_clv DESC;
