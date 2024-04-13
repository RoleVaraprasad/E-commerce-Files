-- ----------------------------------------------------- Olist Store Project --------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------



use olist_store;
-- KPI_1  Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
SELECT IF(WEEKDAY(ORDER_PURCHASE_TIMESTAMP)<5, 'WEEKDDAY', 'WEEKEND') AS WEEKDAY_END,
  COUNT(*) AS PAYMENT_STATISTICS FROM ORDERS
  GROUP BY WEEKDAY_END;
  
  -- KPI_2 Number of Orders with review score 5 and payment type as credit card.
SELECT count(*) as no_of_orders 
FROM reviews AS r 
JOIN payments AS p ON r.order_id = p.order_id
WHERE r.review_score = 5 AND p.payment_type = 'credit_card';

-- KPI_3 Average number of days taken for order_delivered_customer_date for pet_shop
SELECT avg(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS Average_days FROM orders AS o
JOIN items i ON o.order_id = i.order_id
JOIN products p ON i.product_id = p.product_id
WHERE product_category_name = 'pet_shop';

-- KPI_4 Average price and payment values from customers of sao paulo city
SELECT avg(price) AS avg_price, avg(payment_value) AS avg_payment_value FROM orders AS o
JOIN items i ON o.order_id = i.order_id
JOIN payments p ON o.order_id = p.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_city = 'sao paulo';


-- KPI_5 Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.
SELECT DISTINCT(review_score),
avg(shipping_days) AS avg_shipping_days
FROM ORDERS ORD 
JOIN REVIEWS AS REV ON ORD.ORDER_ID = REV.ORDER_ID 
GROUP BY review_score 
ORDER BY review_score;

SELECT * FROM ORDERS;

-- ----------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------

