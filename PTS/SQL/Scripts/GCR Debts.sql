-- Coin Orders
select ownerid, paiddate, Amount, Purpose, TokenOwner, token from Payment where companyid = 17 and PaidDate >= '12/1/15' and PaidDate < '1/1/16' and Status = 3 and Amount > 0
and Token = 0
and (
	(Purpose in (104,204) AND Amount > 69.95 ) OR
	(Purpose in (105,205) AND Amount > 299.95 ) 
	)
order by PaidDate, Amount desc

-- December Packages
select ownerid, paiddate, Amount, Purpose, TokenOwner, token from Payment where companyid = 17 and PaidDate >= '12/1/15' and PaidDate < '1/1/16' and Status = 3 and Amount > 0
--and (
--	(Purpose in (104,204) AND Amount > 69.95 ) OR
--	(Purpose in (105,205) AND Amount > 299.95 ) 
--	)
order by PaidDate, Amount desc


--unpaid bonuses
Select memberid, namelast, namefirst, (SELECT ISNULL(SUM(Amount),0) FROM Payout WHERE OwnerType = 4 AND OwnerID = me.memberid AND Status IN (1,4,5,7)) 'Bonus'
from Member as me where CompanyID = 17 and Status = 1


