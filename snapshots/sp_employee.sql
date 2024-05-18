{% snapshot sp_employee %}

{{
    config(
        target_schema = 'snapshots',
        unique_key='nationalidnumber',
        strategy='check',
        check_cols=['businessentityid', 'firstname', 'lastname', 'nationalidnumber', 'gender','name']
    )
}}

select
    *
from {{ ref('stg_employee') }}

{% endsnapshot %}