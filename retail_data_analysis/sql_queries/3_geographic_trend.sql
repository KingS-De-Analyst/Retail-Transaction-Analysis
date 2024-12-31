-- Which countries generate the most revenue for the business?

SELECT c.country,
    SUM(t.unit_price * t.quantity) AS total_revenue
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY country
ORDER BY total_revenue DESC;

/* 
    Revenue by country for market focus.
    This first queery gives us update on the countries with regards to the their perfomances based on revenue.
    This shows that USA is leading as sales to USA generates the most revenue.
*/

--Query for the list of countries with the highest number of customers and purchases

SELECT c.country,
    SUM(t.quantity) AS total_purchases,
    COUNT(DISTINCT t.customer_id) AS unique_customers
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_purchases DESC;

/*
My analysis gives us an insight into countries that contribute the most sales or have
the highest number of unique customers. It shows us that USA is the country with the highest number of unique customers and number of purchases.
*/


SELECT c.city, c.state, c.country,
    SUM(t.unit_price * t.quantity) AS total_revenue
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY country, state, city
ORDER BY total_revenue DESC;

/*  
    Revenue by country, state and city for market focus.
    This query gives us more insight on the performances on city based on revenue, and giving the details of the state and coutry.
    This shows us that on city level 2 cities from Australia are leading.
*/

