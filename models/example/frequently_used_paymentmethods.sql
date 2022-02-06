{{ config(materialized = 'table') }}
-- select distinct paymentmethod as diff_payment_methods
-- from {{ source('stripe', 'payment') }}

 select paymentmethod, count(1) as frequently_used_paymentmethods from
  {{ source('stripe', 'payment') }}
  group by paymentmethod
  order by frequently_used_paymentmethods

