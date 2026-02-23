-- View: public.revenue_by_state

-- DROP VIEW public.revenue_by_state;

CREATE OR REPLACE VIEW public.revenue_by_state
 AS
 SELECT c.customer_state,
    count(DISTINCT o.order_id) AS total_orders,
    round(sum(oi.price + oi.freight_value), 2) AS revenue,
    round(avg(oi.price + oi.freight_value), 2) AS avg_order_value
   FROM orders_raw o
     JOIN order_items_raw oi ON o.order_id::text = oi.order_id::text
     JOIN customers_raw c ON o.customer_id::text = c.customer_id::text
  WHERE o.order_status::text = 'delivered'::text
  GROUP BY c.customer_state;

ALTER TABLE public.revenue_by_state
    OWNER TO postgres;

