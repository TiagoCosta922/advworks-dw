{% snapshot sp_shipment %}

{{
    config(
        target_schema = 'snapshots',
        unique_key='ShipMethodID',
        strategy='timestamp',
        updated_at= 'DateModify'
    )
}}

select
    *
from {{ ref('stg_shipment') }}

{% endsnapshot %}