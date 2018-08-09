select me.MemberID, me.NameFirst, me.NameLast, me.PaidDate 
from Member as me
left outer join Address as ad on me.MemberID = ad.ownerid
where me.CompanyID = 14 
and ad.CountryID = 102
and 0 < (
	select COUNT(*) from Payment as pa
	join SalesOrder as so on pa.OwnerID = so.SalesOrderID
	where so.memberid = me.Memberid and pa.Status = 3 and pa.PayDate > '10/14/14' 
)
order by me.memberid
