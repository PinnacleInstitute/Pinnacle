-- Cancel CloudZow Members with 3 declined payments since 12/1/12
select Status, * 
--update me set status = 6, enddate = '3/21/13'
from Member as me   
join (
select ownerid,COUNT(*) as cnt
from Payment 
where status = 4 
and PayDate > '12/1/12'
group by OwnerID
having COUNT(*) > 2
) as tmp on me.MemberID = tmp.OwnerID
where me.CompanyID = 5 and me.Status <= 4
 

--select top 1 * from payment