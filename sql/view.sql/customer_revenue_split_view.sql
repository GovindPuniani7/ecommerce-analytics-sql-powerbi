-- View: public.customer_revenue_split

-- DROP VIEW public.customer_revenue_split;

CREATE OR REPLACE VIEW public.customer_revenue_split
 AS
 WITH customer_orders AS (
         SELECT c.customer_unique_id,
            o.order_id,
            row_number() OVER (PARTITION BY c.customer_unique_id ORDER BY o.order_purchase_timestamp) AS order_rank
           FROM orders_raw o
             JOIN customers_raw c ON o.customer_id::text = c.customer_id::text
          WHERE o.order_status::text = 'delivered'::text
        )
 SELECT
        CASE
            WHEN co.order_rank = 1 THEN 'First Order'::text
            ELSE 'Repeat Order'::text
        END AS order_type,
    round(sum(oi.price + oi.freight_value), 2) AS revenue
   FROM customer_orders co
     JOIN order_items_raw oi ON co.order_id::text = oi.order_id::text
  GROUP BY (
        CASE
            WHEN co.order_rank = 1 THEN 'First Order'::text
            ELSE 'Repeat Order'::text
        END);

ALTER TABLE public.customer_revenue_split
    OWNER TO postgres;

