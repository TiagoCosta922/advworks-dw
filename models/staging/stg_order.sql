select porder.purchaseorderid as purchaseorder_id,
       porder.employeeid as employee_id,
       prod.productID as product_id,
	   porder.vendorid as vendor_id,
	   porder.shipmethodID as ship_method_id,
       porder.revisionnumber as revision_number,
       pod.orderqty,
       pod.unitprice,
       pod.receivedqty,
       pod.rejectedqty,
	   case when porder.status = 1 then 'awaiting'
	        when porder.status = 2 then 'accpeted'
			when porder.status = 3 then 'denied'
			else 'Complete'
		END as stateorder,
	   porder.orderdate,
       porder.shipdate,
       porder.modifieddate,
	   porder.subtotal,
	   porder.taxamt,
	   porder.freight
  from {{ source("purchasing", "purchaseorderheader") }} porder
  join {{ source("purchasing", "purchaseorderdetail") }} pod on porder.purchaseorderid = pod.purchaseorderid
  join {{ source("production", "product") }} prod on pod.productid = prod.productid
