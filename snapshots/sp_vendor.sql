{% snapshot sp_vendor %}

{{
    config(
        target_schema = 'snapshots',
        unique_key='VendorID',
        strategy='check',
        check_cols=['name', 'creditrating', 'preferredvendorstatus', 'activeflag', 'purchasingwebserviceurl','minorderqty',
                    'maxorderqty', 'onorderqty', 'lastreceiptcost', 'lastreceiptdate', 'averageleadtime',
                    'productid', 'productname']
    )
}}

select
    *
from {{ ref('stg_vendor') }}

{% endsnapshot %}