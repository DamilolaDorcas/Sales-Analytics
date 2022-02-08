{{ config(materialized = 'table') }}
select status, count(1) as success_rate
from {{ source('stripe', 'payment') }}
group by 1
order by 2

 