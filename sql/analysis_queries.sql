-- Total Revenue
SELECT SUM(oi.price * oi.quantity) AS total_revenue
FROM order_items_raw oi;

-- Average Order Value
SELECT 
    SUM(oi.price * oi.quantity) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM orders_raw o
JOIN order_items_raw oi 
ON o.order_id = oi.order_id;

-- Repeat Customer Rate
SELECT 
    COUNT(DISTINCT customer_id) FILTER (WHERE order_count > 1) * 100.0 
    / COUNT(DISTINCT customer_id) AS repeat_customer_rate
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM orders_raw
    GROUP BY customer_id
) sub;

-- Revenue by State
SELECT customer_state, SUM(oi.price * oi.quantity) AS revenue
FROM customers_raw c
JOIN orders_raw o ON c.customer_id = o.customer_id
JOIN order_items_raw oi ON o.order_id = oi.order_id
GROUP BY customer_state
ORDER BY revenue DESC;