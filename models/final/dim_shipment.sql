with first_version as (
    select
        dbt_scd_id,
        shipmethodid,
        transportername,
        priceship,
        identifyierunique,
        datemodify,
        dbt_valid_from,
        dbt_valid_to,
        dbt_updated_at,
        row_number() over(partition by shipmethodiD order by dbt_valid_from) as row_nr
    from {{ ref('sp_shipment') }}
)
select
    dbt_scd_id as sk_shipment,
    shipmethodid,
    transportername,
    priceship,
    identifyierunique,
    datemodify,
    case
        when row_nr = 1 then '1970-01-01'
        else dbt_valid_from
    end as valid_from,
    coalesce(dbt_valid_to, '2200-01-01') as valid_to,
    dbt_updated_at as last_updated_at
from first_version