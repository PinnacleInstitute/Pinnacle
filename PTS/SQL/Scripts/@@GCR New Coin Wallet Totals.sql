select me.memberid, me.Email, au.Password, CAST(me.reference as float) + cast(me.Referral as float)
from Member as me
join AuthUser as au on me.AuthUserID = au.AuthUserID
where me.CompanyID = 17 and Status IN (1,2)
order by CAST(me.reference as float) + cast(me.Referral as float) desc

--update member set reference = 0 where CompanyID = 17 and Status IN (1,2) and reference = ''
--update member set referral = 0 where CompanyID = 17 and Status IN (1,2) and referral = ''

--select sum(CAST(me.reference as float) + cast(me.Referral as float)) from Member as me where me.CompanyID = 17 and Status IN (1,2)

