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
    user_id as customer_id,
    order_date
    from {{ source('jaffle_shop', 'orders') }}

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