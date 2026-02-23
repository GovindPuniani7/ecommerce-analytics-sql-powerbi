-- View: public.order_status_summary

-- DROP VIEW public.order_status_summary;

CREATE OR REPLACE VIEW public.order_status_summary
 AS
 SELECT order_status,
    count(*) AS total_orders
   FROM orders_raw
  GROUP BY order_status;

ALTER TABLE public.order_status_summary
    OWNER TO postgres;

