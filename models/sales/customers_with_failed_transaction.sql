{{ config(materialized = 'table') }}


with customers as (
select * from {{ref('stg_customers')}}
),

orders as (
select * from {{ref('stg_orders')}}

),


payments as (
    select 
        orderid as order_id,
        amount,
        paymentmethod,
        status
    from {{ source('stripe', 'payment') }}
),

customer_orders as (
select concat(first_name, '  ', last_name) as full_name,
order_id
from customers
join orders 
using (customer_id)
),

final as (
select full_name,
paymentmethod,
status
from customer_orders
join payments using(order_id)
where status = 'fail'
)

select * from final
