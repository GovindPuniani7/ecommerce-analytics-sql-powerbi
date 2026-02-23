-- Data Import Commands

COPY customers_raw 
FROM 'path_to_customers.csv'
DELIMITER ','
CSV HEADER;

COPY orders_raw 
FROM 'path_to_orders.csv'
DELIMITER ','
CSV HEADER;

COPY order_items_raw 
FROM 'path_to_order_items.csv'
DELIMITER ','
CSV HEADER;