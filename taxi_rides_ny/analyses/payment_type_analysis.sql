-- Analysis of payment_type distribution in source vs staging

-- Original source data
select 
  'source' as data_source,
  payment_type,
  count(*) as record_count
from {{ source('staging','green_tripdata') }}
group by payment_type
order by record_count desc

union all

-- Staging data  
select 
  'staging' as data_source,
  cast(payment_type as string) as payment_type,
  count(*) as record_count
from {{ ref('stg_green_tripdata') }}
group by payment_type
order by record_count desc