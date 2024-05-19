SELECT
	p.productID,
    p.name AS ProductName,
    p.productnumber,
	p.safetystocklevel,
	p.reorderpoint,
	p.standardcost,
	p.listprice,
	p.productLine,
	p.class,
	p.productsubcategoryid,
	ps.name AS productsubcategoryname,
	pc.name AS productcategoryname,
	p.productmodelid,
	pm.name AS productmodelname
from {{ source("production", "product") }} p
join {{ source("production", "productsubcategory") }} ps on p.productsubcategoryid = ps.productsubcategoryid
join {{ source("production", "productsubcategory") }} pc on ps.productcategoryid = pc.productcategoryid
join {{ source("production", "productmodel") }} pm on p.productmodelid = pm.productmodelid
