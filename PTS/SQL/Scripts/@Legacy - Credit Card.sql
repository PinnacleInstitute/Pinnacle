select pa.PaidDate, pa.Total, so.MemberID, me.namefirst, me.namelast, pa.description 
from SalesOrder as so
join Payment as pa on so.SalesOrderID = pa.OwnerID and pa.OwnerType = 52
join Member as me on so.MemberID = me.memberid
where pa.CompanyID = 14
and pa.PaidDate >= '7/1/14' and pa.PaidDate < '8/1/14' 
and pa.description like '%4846790104320763%'
