{{ config(materialized = 'table') }}


    -- select * (
        select
    min(amount) as min_payment,
    max(amount) as max_payment, 
    count(orderid) as number_of_orders, 
    avg(amount) as avg_payment,
    sum(amount) as total_payment
    from {{ source('stripe', 'payment') }}
    

