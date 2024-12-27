-- How do product sales differ across countries?

SELECT CONCAT(t.product, ' / ', t.p_brand) AS product_n_brand, c.country,
    SUM(t.quantity) AS total_sold
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY c.country, t.product, t.p_brand
ORDER BY total_sold DESC;

/*
My analysis here is to showcase the best-selling products in each coutry, enabling localized marketing strategies.
 */



SELECT c.country,
    SUM(t.quantity) AS total_purchases,
    COUNT(DISTINCT t.customer_id) AS unique_customers
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_purchases DESC;

/*
    This gives us an insight into countries that contributes the most sales or have the highest number of unique customers.
    Unlike in the previous analysis on goegraphic trend, here we are looking for the perfomances of the countries based on
    number of purcahses made and on the number of unique customers.
*/