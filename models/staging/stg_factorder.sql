SELECT
    pod.purchaseorderid,
    pod.purchaseorderdetailid,
    po.orderdate,
    po.shipdate,
    po.status,
    po.vendorid,
    pod.productid,
    pod.orderqty,
    pod.unitprice,
    pod.receivedqty,
	pod.rejectedqty,
    po.shipmethodid,
    po.subtotal,
    po.taxamt,
    po.freight,
    po.modifieddate
from {{ source("purchasing", "purchaseorderdetail") }} pod
join {{ source("purchasing", "purchaseorderheader") }} po ON pod.purchaseorderid = po.purchaseorderid