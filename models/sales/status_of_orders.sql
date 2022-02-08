
select status, 
count(1) as number
 from {{ source('jaffle_shop', 'orders') }}
group by status
order by number desc