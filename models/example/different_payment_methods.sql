-- {{ config(materialized = 'table') }}

-- select status, paymentmethod, 
-- case when status = "success" then "yes"
-- else null end as 
-- from {{ source('stripe', 'payment')}}


-- --{{ source('stripe', 'payment') }}


-- select count(distinct paymentmethod) as payment
--  from {{ source('stripe', 'payment') }}

 
--select distinct paymentmethod as payment_methods, 
select distinct paymentmethod as diff_payment_methods
from {{ source('stripe', 'payment') }}
--order by 1
 

