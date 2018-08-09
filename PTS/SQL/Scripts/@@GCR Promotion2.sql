
DECLARE @Tmp TABLE(
   MemberID int ,
   NameFirst nvarchar(30), 
   NameLast nvarchar(30), 
   Amount money,
   Lvl int 
)

INSERT INTO @Tmp
select A.MemberID, A.NameFirst, A.NameLast, sum(P.Amount)  'Amount', MIN(1) 'Lvl'
from Payment as P
join Member as B on P.ownertype = 4 and P.ownerid = B.MemberID
join Member as A on B.ReferralID = A.memberID
where P.PaidDate >= '3/1/15' and P.PaidDate < '5/1/15' 
and P.Status = 3
and P.Purpose IN ('103','104','105','106','107','108') 
group by A.MemberID, A.NameFirst, A.NameLast

INSERT INTO @Tmp
select A.MemberID, A.NameFirst, A.NameLast, sum(P.Amount * .1) 'Amount', MIN(2) 'Lvl'
from Payment as P
join Member as C on P.ownertype = 4 and P.ownerid = C.MemberID
join Member as B on C.ReferralID = B.MemberID
join Member as A on B.ReferralID = A.memberID
where P.PaidDate >= '3/1/15' and P.PaidDate < '5/1/15' 
and P.Status = 3
and P.Purpose IN ('103','104','105','106','107','108') 
group by A.MemberID, A.NameFirst, A.NameLast

INSERT INTO @Tmp
select A.MemberID, A.NameFirst, A.NameLast, sum(P.Amount * .1) 'Amount', MIN(3) 'Lvl'
from Payment as P
join Member as D on P.ownertype = 4 and P.ownerid = D.MemberID
join Member as C on D.ReferralID = C.MemberID
join Member as B on C.ReferralID = B.MemberID
join Member as A on B.ReferralID = A.memberID
where P.PaidDate >= '3/1/15' and P.PaidDate < '5/1/15' 
and P.Status = 3
and P.Purpose IN ('103','104','105','106','107','108') 
group by A.MemberID, A.NameFirst, A.NameLast


select MemberID, NameFirst, NameLast, sum(Amount) 'Amount' from @Tmp
group by MemberID, NameFirst, NameLast order by SUM(amount) desc

select * from @Tmp order by MemberID, Lvl
