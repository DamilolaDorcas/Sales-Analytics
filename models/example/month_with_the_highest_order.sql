
{{ config(materialized = 'table') }}
--with order as (
SELECT
     extract(month from order_date) month, count(order_date) as number_of_orders
     from {{ source('jaffle_shop', 'orders') }}
      group by 1
      

 