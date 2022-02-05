{{ config(materialized = 'table') }}
with customers as (
select
    id as customer_id,
    first_name,
    last_name
    from {{ source('jaffle_shop', 'customers') }}
),

orders as (
select 
    id as order_id,
    user_id as customer_id
    from {{ source('jaffle_shop', 'orders') }}

),

payments as(
    select
        --id as customer_id, 
        orderid as order_id,
        amount
    from {{ source('stripe', 'payment') }}
),

customer_orders as(
    SELECT concat(first_name, ' ', last_name) as full_name,
    order_id
    --amount
    from customers
    join orders 
    using(customer_id)
),

final as( 
    SELECT 
    min(amount),
    max(amount),
    amount
    from customer_orders
    join payments using(order_id)
    
    )

    select * from final
