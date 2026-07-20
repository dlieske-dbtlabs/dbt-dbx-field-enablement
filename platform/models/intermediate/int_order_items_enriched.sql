{{ config(materialized='view') }}


with order_items as (
    select * from {{ ref('stg_order_items') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),
products as (
    select * from {{ ref('stg_products') }}
),
enriched as (
    select
        oi.order_item_id,
        oi.order_id,
        o.order_date,
        o.status,
        o.customer_id,
        oi.product_id,
        p.product_name,
        p.category,
        oi.quantity,
        oi.unit_price,
        oi.line_total
    from order_items oi
    left join orders o on oi.order_id = o.order_id
    left join products p on oi.product_id = p.product_id
)
select * from enriched

