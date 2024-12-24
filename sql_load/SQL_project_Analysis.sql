SELECT a.name, a.gender, a.income, b.product, b.payment_mehtod
FROM customers AS a
LEFT JOIN transactions as b ON 
a.customer_id = b.customer_id
--WHERE payment_mehtod = 'Credit Card'
;

SELECT name, email, phone, age FROM customers
WHERE age < 30;

SELECT * FROM customers;

-- Top spenders for targeted marketing.
SELECT customer_id,
    SUM(unit_price * quantity) AS total_spent
FROM transactions
GROUP BY customer_id
ORDER BY total_spent DESC;

-- Popular products to stock more.

SELECT CONCAT(product, ' / ', p_brand) AS product_n_brand,
    SUM(quantity) AS total_sold
FROM transactions
GROUP BY product, p_brand
ORDER BY total_sold DESC;


-- Revenue by country for market focus.
SELECT c.country,
    SUM(t.unit_price * t.quantity) AS total_revenue
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY country
ORDER BY total_revenue DESC;


-- Revenue by country, state and city for market focus.
SELECT c.city, c.state, c.country,
    SUM(t.unit_price * t.quantity) AS total_revenue
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY country, state, city
ORDER BY total_revenue DESC;


-- Insight into the sales trends for different products across various countries.
SELECT c.country,
    CONCAT(t.product, ' / ', t.p_brand) AS product_n_brand,
    SUM(t.quantity) AS total_sold
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY c.country, t.product, t.p_brand
ORDER BY total_sold DESC;

-- Insight inot countries that contributes the most to sales or have the highest number of unique customers

SELECT c.country,
    SUM(t.quantity) AS total_purchases,
    COUNT(DISTINCT t.customer_id) AS unique_customers
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_purchases DESC;


-- Impact of payment method on feedback sentiment
SELECT t.payment_method,
    COUNT(f.transaction_id) AS feedback_count,
    AVG(f.ratings) AS avg_rating
FROM feedback AS f
JOIN transactions AS t ON f.transaction_id = t.transaction_id
GROUP BY t.payment_method
ORDER BY avg_rating DESC;

-- Transaction distribution by payment method
SELECT payment_method,
    count(*) AS transaction_count,
    SUM(unit_price * quantity) AS total_revenue
FROM transactions
GROUP BY payment_method
ORDER BY total_revenue DESC;
