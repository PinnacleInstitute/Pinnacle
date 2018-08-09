--CHECK FOR WALLET PAYMENTS WITH A MISSING PAYOUT RECORD
select pa.PaymentID, pa.OwnerID, pa.PaidDate, pa.Amount, pa.reference from Payment AS pa
left outer join Payout as po on pa.Reference = CAST(po.PayoutID AS VARCHAR(10))
 where pa.CompanyID  = 17 and pa.PayType = 10 and pa.Status = 3
 and po.payoutid is null
 
--CHECK FOR WALLET PAYMENTS WITH A DIFFERENT PAYOUT RECORD DEBIT AMOUNT
select pa.PaymentID, pa.OwnerID, pa.PaidDate, pa.Amount, pa.reference, po.Amount from Payment AS pa
left outer join Payout as po on pa.Reference = CAST(po.PayoutID AS VARCHAR(10))
 where pa.CompanyID  = 17 and pa.PayType = 10 and pa.Status = 3
and pa.amount <> po.amount * -1
order by pa.PaidDate
 


--CHECK FOR WALLET TRANSFERS WITH A MISSING PAYOUT RECORD
-- BAD CODE
--select * 
----delete pa
--from Payout AS pa
--left outer join Payout as po on pa.Reference = CAST(po.PayoutID AS VARCHAR(10))
-- where pa.CompanyID  = 17 and pa.PayType = 92 and pa.Amount > 0 
-- and po.payoutid is null
 
--CHECK FOR DUPLICATE TRANSFERS
select ownerid, paydate, amount, reference, COUNT(*) 
from Payout 
where CompanyID = 17 and paytype = 92 and Amount < 0
group by ownerid, paydate, amount, reference
having COUNT(*) > 1
order by PayDate


select OwnerID, COUNT(*) from Payout where companyid = 17 and PayType = 92 and PayDate = '4/24/15'
group by ownerid 
order by COUNT(*) desc


select PayoutID, OwnerID, PayDate, amount, reference from Payout as pa
where CompanyID = 17 and PayType = 92 and Amount > 0
and 0 = (select COUNT(*) from payout where OwnerID = CAST(pa.Reference as int) and PayType = 92 and PayDate = pa.PayDate and ABS(Amount) = pa.Amount)

-- Transfer Credits with missing Debit
select PayoutID, OwnerID, PayDate, amount, reference from Payout as pa
where CompanyID = 17 and PayType = 92 and Amount > 0
and 0 = (select COUNT(*) from payout where OwnerID = CAST(pa.Reference as int) and PayType = 92 and PayDate = pa.PayDate and ABS(Amount) = pa.Amount)

-- Recent Payments from Negative Balances
select memberid, namefirst, namelast from Member as me
where CompanyID = 17  
and -500 > ( SELECT ISNULL(SUM(Amount),0) FROM Payout WHERE OwnerType = 4 AND OwnerID = me.memberid AND Status IN (1,4,5,7) AND Show = 0)
and 0 < (select COUNT(*) from Payout WHERE OwnerType = 4 AND OwnerID = me.memberid AND PayDate > '4/1/15' and PayType = 90)


