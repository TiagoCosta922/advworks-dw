{% snapshot sp_product %}

{{
    config(
        target_schema = 'snapshots',
        unique_key='productID',
        strategy='check',
        check_cols=['ProductName', 'productnumber', 'safetystocklevel', 'reorderpoint', 'standardcost','lastprice',
                    'productLine', 'class', 'productsubcategoryid', 'productsubcategoryname', 'productcategoryname',
                    'productmodelid', 'productmodelname']
    )
}}

select
    *
from {{ ref('stg_product') }}

{% endsnapshot %}