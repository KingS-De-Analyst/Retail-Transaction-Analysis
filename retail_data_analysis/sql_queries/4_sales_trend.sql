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