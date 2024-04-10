create database if not exists olist_store;
use olist_store;
create table orders
(
order_id varchar(255),
order_purchase_timestamp date,
order_delivered_customer_date date
);

select * from olist_store;

load data infile 'H:\vara\ExcelR\Project\Project 6 - E-Commerce (6 PM - 7 PM)\olist_orders_dataset.csv' into table orders
fields terminated by ','
ignore 1 lines;

use olist_store;
select * from olist_orders_dataset;
select * from geolocation;
select * from olist_store.olist_orders_dataset;

use olist_store;

select count(*) from olist_store.items;
SELECT
  order_id,
  order_purchase_timestamp,
  order_delivered_customer_date,
  DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) AS shipping_days
FROM orders;

select
order_id,
  order_purchase_timestamp,
  order_delivered_customer_date,
  weekday(order_purchase_timestamp) as weekday_end
  from orders;


-- ***********************************************************************************

use olist_store;
select * from olist_store.order;

-- alter table olist_store.order
-- add customer_id varchar(255) null;

/*UPDATE orders
JOIN olist_orders ON orders.order_id = olist_orders.order_id
SET orders.customer_id = olist_orders.customer_id;*/

alter table olist_store.order add column weekday_end varchar(255);
insert into olist_store.order values(
  order_id,
  customer_id,
  order_purchase_timestamp,
  order_delivered_customer_date,
  weekday(order_purchase_timestamp));

 select * from olist_store.order;

 set sql_safe_updates = 0;
 
 # alter table olist_store.order drop column weekday_end;
 
UPDATE olist_store.order
SET weekday_end = CASE 
    WHEN DAYOFWEEK(order_purchase_timestamp) IN (1,7) THEN 'weekend'
    ELSE 'weekday'
END;

  
select count(weekday_end) as weekend from olist_store.order where weekday_end ='weekday';
select count(weekday_end) as weekday from olist_store.order where weekday_end ='weekend';

/* simple query */

select if(weekday(order_purchase_timestamp)<5, 'weekday' , 'weekend') as payment_type,
count(*) as total_payments from olist_store.order
group by payment_type;
   
select weekday_end, count(*) as pay group by weekday_end;

