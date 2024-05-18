SELECT
	per.businessentityid,
	per.firstname,
	per.lastname,
    e.nationalidnumber, 
    e.gender, 
    s.name
from {{ source("humanresources", "employee") }} e
    join {{ source("humanresources", "employeedepartmenthistory") }} edh on e.businessentityid = edh.businessentityid
    join {{ source("humanresources", "shift") }} s on edh.shiftid = s.shiftid
    join {{ source("person", "person") }} per on edh.businessentityid = per.businessentityid
