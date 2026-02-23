-- View: public.monthly_performance

-- DROP VIEW public.monthly_performance;

CREATE OR REPLACE VIEW public.monthly_performance
 AS
 SELECT date_trunc('month'::text, o.order_purchase_timestamp) AS month,
    count(DISTINCT o.order_id) AS monthly_orders,
    round(sum(oi.price + oi.freight_value), 2) AS monthly_revenue
   FROM orders_raw o
     JOIN order_items_raw oi ON o.order_id::text = oi.order_id::text
  WHERE o.order_status::text = 'delivered'::text
  GROUP BY (date_trunc('month'::text, o.order_purchase_timestamp))
  ORDER BY (date_trunc('month'::text, o.order_purchase_timestamp));

ALTER TABLE public.monthly_performance
    OWNER TO postgres;

