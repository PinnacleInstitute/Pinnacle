
select ownerid, count(*)  
from Payment as pa
join Member as me on pa.ownertype = 4 and pa.ownerid = me.MemberID
join authuser as au on me.AuthUserID = au.AuthUserID
where pa.Status = 3
and Purpose IN ('103','104','105','106','107','108','203','204','205','206','207','208') 
group by OwnerID
order by COUNT(*) desc

