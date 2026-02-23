-- Table: public.customers_raw

-- DROP TABLE IF EXISTS public.customers_raw;

CREATE TABLE IF NOT EXISTS public.customers_raw
(
    customer_id character varying(50) COLLATE pg_catalog."default",
    customer_unique_id character varying(50) COLLATE pg_catalog."default",
    customer_zip_code_prefix integer,
    customer_city character varying(50) COLLATE pg_catalog."default",
    customer_state character varying(2) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers_raw
    OWNER to postgres;