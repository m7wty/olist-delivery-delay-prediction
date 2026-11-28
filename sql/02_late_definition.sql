-- Late definition: delivered date > estimated date, compared by date only.
-- Estimated date has no time (always 00:00:00), so a full-timestamp
-- comparison wrongly flags 1,292 same-day deliveries as late.
-- Result: 6,534 late of 96,470 delivered orders (6.77%), vs 7,826 (8.11%).

SELECT
  COUNT(*) AS total_orders,
  SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
           THEN 1 ELSE 0 END) AS late_timestamp,
  SUM(CASE WHEN date(order_delivered_customer_date) > date(order_estimated_delivery_date)
           THEN 1 ELSE 0 END) AS late_date_only
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;