DECLARE @ToDate datetime
SET @ToDate = DATEADD(m,-1,GETDATE())

select count(*)  
from Payment as pa
join Member as me on pa.ownertype = 4 and pa.ownerid = me.MemberID
join authuser as au on me.AuthUserID = au.AuthUserID
where pa.Status = 3
and pa.paiddate >= @Todate
and Purpose IN ('103','104','105','106','107','108','203','204','205','206','207','208') 


SELECT MemberID, namefirst, namelast
FROM Member as me
WHERE companyid = 17
and 0 < ( select count(*)  
from Payment as pa
where pa.Status = 3
and ownertype = 4 and ownerid = me.memberid
and Purpose IN ('103','104','105','106','107','108','203','204','205','206','207','208') 
)
order by MemberID

