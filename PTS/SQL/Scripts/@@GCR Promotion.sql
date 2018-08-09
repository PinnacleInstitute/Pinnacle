--select pa.PaidDate, pa.Amount, me.MemberID, au.Logon, me.NameFirst, me.NameLast, me.Email  
--from Payment as pa
--join Member as me on pa.ownertype = 4 and pa.ownerid = me.MemberID
--join authuser as au on me.AuthUserID = au.AuthUserID
--where pa.PaidDate >= '1/1/15' and pa.PaidDate < '1/23/15' 
--and pa.Status = 3
--and Purpose IN ('203','204','205','206','207','208') 
--order by pa.paiddate, pa.amount desc, me.memberid

--select pa.PaidDate, pa.Amount, me.MemberID, au.Logon, me.NameFirst, me.NameLast, me.Email, me2.MemberID 'Sponsor #', au2.Logon 'Sponsor Logon', me2.NameFirst 'Sponsor Firstname', me2.NameLast 'Sponsor Lastname', me2.Email 'Sponsor Email' 
--from Payment as pa
--join Member as me on pa.ownertype = 4 and pa.ownerid = me.MemberID
--join authuser as au on me.AuthUserID = au.AuthUserID
--join Member as me2 on me.ReferralID = me2.memberID
--join authuser as au2 on me2.AuthUserID = au2.AuthUserID
--where pa.PaidDate >= '1/6/15' and pa.PaidDate < '1/23/15' 
--and pa.Status = 3
--and Purpose IN ('103','104','105','106','107','108') 
--order by pa.paiddate, pa.amount desc, me.memberid

--select pa.PaidDate, pa.Amount, me.MemberID, au.Logon, me.NameFirst, me.NameLast, me.Email, me2.MemberID 'Sponsor #', au2.Logon 'Sponsor Logon', me2.NameFirst 'Sponsor Firstname', me2.NameLast 'Sponsor Lastname', me2.Email 'Sponsor Email', Notes  
select dbo.wtfn_DateOnlyStr(pa.PaidDate) 'Date', pa.paymentid, pa.Amount, 
      CASE Purpose
         WHEN '103' THEN 25
         WHEN '104' THEN 50
         WHEN '105' THEN 100
         WHEN '106' THEN 200
         WHEN '107' THEN 300
         WHEN '108' THEN 500
         ELSE 0
      END 'Coins',
au2.Logon 'Sponsor Logon', me2.MemberID 'Sponsor #', me2.NameFirst 'Sponsor Firstname', me2.NameLast 'Sponsor Lastname', me2.Email 'Sponsor Email'  
from Payment as pa
join Member as me on pa.ownertype = 4 and pa.ownerid = me.MemberID
join authuser as au on me.AuthUserID = au.AuthUserID
join Member as me2 on me.ReferralID = me2.memberID
join authuser as au2 on me2.AuthUserID = au2.AuthUserID
where pa.PaidDate >= '4/1/15' and pa.PaidDate < '5/9/15' 
and pa.Status = 3
and Purpose IN ('103','104','105','106','107','108') 
order by pa.paiddate, pa.paymentID

--select me2.MemberID, me2.namefirst, me2.namelast, me2.email, me2.phone1, count(*) 'Count', sum(pa.Amount) 'Total'
--from Payment as pa
--join Member as me on pa.ownertype = 4 and pa.ownerid = me.MemberID
--join authuser as au on me.AuthUserID = au.AuthUserID
--join Member as me2 on me.ReferralID = me2.memberID
--join authuser as au2 on me2.AuthUserID = au2.AuthUserID
--where pa.PaidDate >= '2/1/15' and pa.PaidDate < '2/18/15' 
--and pa.Status = 3
--and Purpose IN ('103','104','105','106','107','108') 
--group by me2.MemberID, me2.namefirst, me2.namelast, me2.email, me2.phone1
--having COUNT(*) >= 5
--order sum(pa.amount) desc
