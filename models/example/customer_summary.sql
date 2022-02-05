{{ config(materialized = 'table') }}


    select
    min(amount) as min_amount, max(amount) as max_amount, count(orderid) as number_of_orders, avg(amount) as avg_amount
    from 
    {{ source('stripe', 'payment') }}

