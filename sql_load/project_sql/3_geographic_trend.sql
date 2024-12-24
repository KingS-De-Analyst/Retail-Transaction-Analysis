/* 
    Revenue by country for market focus.
    This first queery gives us update on the countries with regards to the their perfomances based on revenue,
    and is ordered in a descending order
*/
SELECT c.country,
    SUM(t.unit_price * t.quantity) AS total_revenue
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY country
ORDER BY total_revenue DESC;


/*  
    Revenue by country, state and city for market focus.
    This query gives us more insight on the performances on city based on revenue, and giving the details of the state and coutry,
    then ordering them in a descending order 
*/
SELECT c.city, c.state, c.country,
    SUM(t.unit_price * t.quantity) AS total_revenue
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY country, state, city
ORDER BY total_revenue DESC;

