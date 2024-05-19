select porder.purchaseorderid as purchaseorder_id,
       porder.employeeid as employee_id,
	   porder.vendorid as vendor_id,
	   porder.shipmethodID as ship_method_id,
       porder.revisionnumber as revision_number,
	   case when porder.status = 1 then 'awaiting'
	        when porder.status = 2 then 'accpeted'
			when porder.status = 3 then 'denied'
			else 'Complete'
		END as state_order,
	   porder.orderdate,
       porder.shipdate,
	   porder.subtotal,
	   porder.taxamt,
	   porder.freight,
	   porder.modifieddate
  from {{ source("purchasing", "purchaseorderheader") }} porder