SELECT 
    v.businessentityid AS VendorID,
    v.name,
    v.creditrating,
    v.preferredvendorstatus,
    v.activeflag,
    v.purchasingwebserviceurl,
    pv.minorderqty,
    pv.maxorderqty,
    pv.onorderqty,
    pv.lastreceiptcost,
    pv.lastreceiptdate,
    pv.averageleadtime,
    p.productid,
    p.name AS productname
from {{ source("purchasing", "vendor") }} v
join {{ source("purchasing", "productvendor") }} pv on v.businessentityid = pv.businessentityid
join {{ source("production", "product") }} p on pv.productid = p.productid


