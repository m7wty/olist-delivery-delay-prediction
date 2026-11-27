-- 1. Order count per status

SELECT order_status, COUNT(order_status) AS total_orders
FROM orders
GROUP BY order_status 
ORDER BY total_orders DESC;

-- 2. Delivered orders with NULL delivery date (excluded from training)

SELECT order_status, order_delivered_customer_date
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NULL ;

-- 3. Late rate among delivered orders with a delivery date

SELECT COUNT(*) AS total_orders,
  SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) AS late_orders,
  ROUND(
 (SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2) AS late_rate_pct
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;
