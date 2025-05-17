-- Assessment_Q4.sql

-- Estimate CLV based on average profit per transaction and account tenure
WITH transactions_per_customer AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_value
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tenure AS (
    SELECT 
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
),
clv_calc AS (
    SELECT 
        t.customer_id,
        t.name,
        te.tenure_months,
        tc.total_transactions,
        ROUND(((tc.total_transactions / NULLIF(te.tenure_months, 0)) * 12 * ((tc.total_value / tc.total_transactions) * 0.001)) / 100, 2) AS estimated_clv
    FROM tenure te
    JOIN transactions_per_customer tc ON te.customer_id = tc.owner_id
)
SELECT *
FROM clv_calc
ORDER BY estimated_clv DESC;