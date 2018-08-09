--Check for Missing GCR Wallets
select EnrollDate, me.MemberID, au.logon, au.password, me.namefirst, me.namelast from Member as me
join AuthUser as au on me.AuthUserID = au.authuserid
where CompanyID = 17 and status in (1,2) and Reference = ''
order by me.EnrollDate

--Check for Missing GCR Orders
select paymentid, pa.PaidDate, OwnerID, purpose, me.status from payment as pa
join Member as me on pa.OwnerID = me.memberid
where right(pa.notes,9) = 'GCRORDER:' 
and pa.paiddate >= '11/1/14'
order by pa.PaidDate
