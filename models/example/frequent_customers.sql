-- -- THIS GIVES THE USER D AND THE NUMBER OF TIMES THE CUSTOMER COMES BACK

-- -- select user_id, count(1) as distinctuserid
-- -- from {{ source('jaffle_shop', 'orders') }}
-- -- group by 1
-- -- order by 2 desc



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

customers_orders as(
    select 
    concat(first_name, ' ', last_name) as fullname,
    order_id
     from customers
     join orders
     using(customer_id)
),

final as (
    select 
    fullname,
    count(order_id) as frequentcustomers
    from customers_orders
    group by 1
    order by 2 desc

)
select * from final


