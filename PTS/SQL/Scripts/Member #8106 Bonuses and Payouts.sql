select SUM(amount) from Commission where OwnerID = 8106
--1754.13
select SUM(amount) from Commission where OwnerID = 8106 and PayoutID != 0
--1707.71
select SUM(amount) from Commission where OwnerID = 8106 and PayoutID = 0
--46.42

select SUM(Amount) from Payout where OwnerID = 8106  
--1101.50
select SUM(Amount) from Payout where OwnerID = 8106 and Status = 2
--1070.53
select SUM(Amount) from Payout where OwnerID = 8106 and Status = 1
--30.97
select SUM(Amount) from Payout where OwnerID = 8106 and Amount < 0
--641.85
select SUM(Amount) from Payout where OwnerID = 8106 and Amount > 0
--1743.35

select 1101.50 + 641.85
select 1743.35 - 1707.71


select * from Payout where OwnerID = 8106 and Amount < 0 order by PayDate 

select pa.payoutid, pa.Amount, SUM(co.amount)
--select SUM(co.amount)
from commission as co
join Payout as pa on co.PayoutID = pa.PayoutID
where co.OwnerID = 8106
group by pa.payoutid, pa.amount
order by pa.PayoutID

select PayoutID, PayDate, amount from Payout where OwnerID = 8106 and Amount > 0 order by PayoutID

--9885 35.64

select SUM(Amount) from commission where OwnerID = 8106 and commdate > '5/9/13' and commdate < '5/13/13'
--35.64 Double Paid
select * from commission where OwnerID = 8106 and commdate > '5/9/13' and commdate < '5/16/13' order by commdate




--All members Bonuses and Payouts
select me.memberid, 
(select SUM(amount) from Commission where OwnerID = Me.MemberID and PayoutID > 0)'Bonus', 
(select SUM(amount) from Payout where OwnerID = Me.MemberID and Amount > 0)'Payout' 
from Member as me
where me.CompanyID = 9 and me.status = 1
and 0 < ( select COUNT(*) from commission where ownerid = me.memberid)
group by me.memberid
order by me.MemberID

