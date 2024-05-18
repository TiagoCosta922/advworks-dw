select nationalidnumber
from {{ source ('humanresources', 'employee') }}