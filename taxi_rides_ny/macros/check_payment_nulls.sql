{% macro check_payment_nulls() %}
  {% set query %}
    select 
      'source' as data_source,
      case when payment_type is null then 'NULL' else cast(payment_type as string) end as payment_type,
      count(*) as record_count
    from {{ source('staging','green_tripdata') }}
    group by payment_type
    order by record_count desc
    limit 10
  {% endset %}
  
  {% set results = run_query(query) %}
  
  {% if execute %}
    {% for row in results %}
      {{ log(row[0] ~ " | " ~ row[1] ~ " | " ~ row[2], info=True) }}
    {% endfor %}
  {% endif %}
{% endmacro %}