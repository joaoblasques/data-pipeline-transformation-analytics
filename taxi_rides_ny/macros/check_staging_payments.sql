{% macro check_staging_payments() %}
  {% set query %}
    select 
      'staging' as data_source,
      payment_type,
      count(*) as record_count
    from {{ ref('stg_green_tripdata') }}
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