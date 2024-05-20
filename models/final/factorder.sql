WITH dimension_ids AS (
    SELECT
        pur.purchaseorder_id,
        v.VendorID,
        e.businessentityid AS employee_id,
        sh.ShipMethodID AS shipment_id,
        pp.productID,
        pur.orderdate,
        pur.stateorder,
        pur.shipdate,
        pur.subtotal,
        pur.taxamt,
        pur.freight      
    FROM {{ ref('stg_order') }} pur
    LEFT JOIN {{ ref('stg_vendor') }} v ON pur.vendor_id = v.VendorID
    LEFT JOIN {{ ref('stg_employee') }} e ON pur.employee_id = e.businessentityid
    LEFT JOIN {{ ref('stg_shipment') }} sh ON pur.ship_method_id = sh.ShipMethodID
    LEFT JOIN {{ ref('stg_product') }} pp ON pur.product_id = pp.productID

),

surrogate_keys AS (
    SELECT
        dids.purchaseorder_id AS purchase_id,
        dvend.sk_vendor AS sk_vendor,
        demp.sk_employee AS sk_employee,
        dship.sk_shipment AS sk_shipment,
        dpro.sk_product AS sk_product,
        order_dd.sk_date AS sk_order_date,
        ship_dd.sk_date AS sk_shipment_date,
        dids.stateorder,
        dids.subtotal,
        dids.taxamt,
        dids.freight   
    FROM dimension_ids dids
    JOIN {{ ref('dim_date') }} order_dd ON dids.orderdate = order_dd.date
    LEFT JOIN {{ ref('dim_date') }} ship_dd ON dids.shipdate = ship_dd.date
    JOIN {{ ref('dim_vendor') }} dvend ON dids.VendorID = dvend.VendorID
        AND dids.orderdate BETWEEN dvend.valid_from AND dvend.valid_to
    LEFT JOIN {{ ref('dim_employee') }} demp ON dids.employee_id = demp.businessentityid
        AND dids.orderdate BETWEEN demp.valid_from AND demp.valid_to
    LEFT JOIN {{ ref('dim_shipment') }} dship ON dids.shipment_id = dship.shipmethodid
        AND dids.orderdate BETWEEN dship.valid_from AND dship.valid_to
    LEFT JOIN {{ ref('dim_product') }} dpro ON dids.productID = dpro.productID
        AND dids.orderdate BETWEEN dpro.valid_from AND dpro.valid_to
),

final AS (
    SELECT
        purchase_id,
        sk_vendor,
        sk_employee,
        sk_shipment,
        sk_product,
        sk_order_date,
        sk_shipment_date,
        stateorder,
        subtotal,
        taxamt,
        freight 
    FROM surrogate_keys
)

SELECT
    *
FROM final
