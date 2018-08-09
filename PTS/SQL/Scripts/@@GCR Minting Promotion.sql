DECLARE @FromDate datetime, @ToDate datetime
SET @FromDate = '10/13/15'
SET @ToDate = '10/18/15'

select pa.PaidDate, pa.amount, me.MemberID, me.NameFirst + ' ' + me.NameLast 'Name', me.Email 
from Payment as pa
join Member as me ON pa.OwnerID = me.MemberID
where pa.CompanyID = 17 and pa.Status = 3
and pa.PaidDate >= @FromDate and pa.PaidDate <= @ToDate
and pa.Amount > 0 and me.Status = 1
order by pa.PaidDate
