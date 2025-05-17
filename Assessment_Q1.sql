-- Assessment_Q1.sql

-- Find customers with at least one funded savings plan and one funded investment plan
SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT i.id) AS investment_count,
    ROUND(SUM(sa.confirmed_amount) / 100, 2) AS total_deposits
FROM users_customuser u
JOIN plans_plan s ON u.id = s.owner_id AND s.is_regular_savings = 1
JOIN plans_plan i ON u.id = i.owner_id AND i.is_a_fund = 1
JOIN savings_savingsaccount sa ON sa.plan_id = s.id
WHERE s.amount > 0 AND i.amount > 0
GROUP BY u.id, u.first_name, u.last_name
HAVING savings_count >= 1 AND investment_count >= 1
ORDER BY total_deposits DESC;

