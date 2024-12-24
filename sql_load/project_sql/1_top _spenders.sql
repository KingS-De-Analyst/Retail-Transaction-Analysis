/*
Here we are looking to identify high-value customers (top spenders) based on purchase frequency or spending for targeted marketing
because understanding high-value customers is a priority for marketing and customer relationship management.
This analysis will give us a list of top spenders, their spending percentage, and sort them by the amount spent.
*/

-- Query for the list of the top spenders.
SELECT c.customer_id, c.name, c.email,
    SUM(t.unit_price * t.quantity) AS total_spent
FROM transactions AS t
JOIN customers AS c ON c.customer_id = t.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;


-- Query for the list of the top spenders with their spending percentage.
WITH customer_totals AS (
    SELECT c.customer_id, c.name, c.email,
    SUM(t.unit_price * t.quantity) AS total_spent
    FROM transactions AS t
    JOIN customers AS  c ON c.customer_id = t.customer_id
GROUP BY c.customer_id
),
max_spent AS (
    SELECT MAX( total_spent) AS highest_spent
    FROM customer_totals
)
SELECT ct.customer_id, ct.name, ct.email, ct.total_spent, (ct.total_spent * 100.0 / ms.highest_spent) AS percentage_of_highest
FROM customer_totals AS ct
CROSS JOIN max_spent AS ms
ORDER BY ct.total_spent DESC;