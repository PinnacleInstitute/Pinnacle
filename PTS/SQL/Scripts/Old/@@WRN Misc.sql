-- ACH Payments to Process
select count(*), sum(amount) from payment as pa
---select pa.* from payment as pa
join member as me on pa.ownerid = me.memberid
where me.companyid = 7 and pa.status = 1 and pa.paytype = 5
--where me.companyid = 7 and pa.status <= 1 and pa.paytype <= 5

-- ACH Payments Processed
select count(*), sum(amount) from payment as pa
join member as me on pa.ownerid = me.memberid
where me.companyid = 7 and pa.paiddate >= '6/6/11' and pa.status = 3

-- ACH Payment - Processing fees
select count(*)'count', SUM(CASE amount WHEN 7.95 THEN 2.95 WHEN 18.95 THEN 3.95 WHEN 39.95 THEN 4.95 WHEN 81.95 THEN 6.95 END)'total',
 SUM(CASE amount WHEN 7.95 THEN 2.45 WHEN 18.95 THEN 3.45 WHEN 39.95 THEN 4.45 WHEN 81.95 THEN 6.45 END)'profit'
from payment as pa
join member as me on pa.ownerid = me.memberid
--where me.companyid = 7 and pa.status = 1 and pa.paytype = 5
where me.companyid = 7 and pa.paiddate >= '6/6/11' and pa.status = 3

-- ACH Payments - Grouped By Amount
select amount, count(paymentid), SUM(Amount)
from payment as pa
join member as me on pa.ownerid = me.memberid
where me.companyid = 7 and pa.status >= 1 and pa.status <= 3  
GROUP BY amount
ORDER BY amount

-- Mark Introductory payment status=0 if ACH Verified is NOT GOOD
select count(*), sum(amount) from payment as pa
select pa.* 
update pa set status = 0
from payment as pa
join member as me on pa.ownerid = me.memberid
join billing as bi on me.billingid = bi.billingid
where me.companyid = 7 and pa.status = 1 and pa.paytype = 5
and bi.verified != 2

-- How many people have ACH Billing Info (BAD)
select count(*) from billing as bi
join member as me on bi.billingid = me.billingid
where me.companyid = 7 and bi.paytype = 2
and bi.verified = 1

-- How many people have paper check for payouts 
select count(*) from billing as bi
join member as me on bi.billingid = me.payid
where me.companyid = 7 and bi.commtype = 3

-- Upgrades
select me.memberid, me.namefirst, me.namelast, count(*)
from payment as pa
join member as me on pa.ownerid = me.memberid and pa.ownertype=4
where me.companyid = 7 and me.Title >= 11 AND pa.status <= 1 and pa.paytype <= 5
group by me.memberid, me.namefirst, me.namelast
having count(pa.PaymentID) > 1

-- Mark a Range of Payments Submitted 
--UPDATE pa SET Status = 2, PaidDate = '6/8/11' 
--Select * 
FROM Payment AS pa
JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
WHERE me.CompanyID = 7 AND pa.Status = 1 AND pa.PayType >= 1 AND pa.PayType <= 5
AND pa.PaymentID >= 27269 AND pa.PaymentID <= 28985

-- Mark a Range of Payments Approved 
--UPDATE pa SET Status = 3
--Select * 
FROM Payment AS pa
JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
WHERE me.CompanyID = 7 AND pa.Status = 2 AND pa.PayType >= 1 
AND pa.PayType <= 5
AND pa.PaidDate = '7/25/11'

--UNDO BONUS RUN 
DECLARE @BonusDate datetime
SET @BonusDate = '7/2/11'
-- Reset Payment records ----------------------
--UPDATE pa SET CommStatus = 1, CommDate = 0 FROM Payment AS pa
--SELECT * FROM Payment AS pa 
--JOIN Member AS me ON pa.OwnerID = me.MemberID
--WHERE me.CompanyID = 7 AND pa.CommStatus = 2 AND pa.CommDate >= @BonusDate
--Update Old Commissions in these payouts ----------------------
--Select * from commission 
--update commission set status = 1, payoutid = 0 
--where payoutid in ( select payoutid from payout where CompanyID = 7 AND CommDate >= @BonusDate) and amount < 0
--Delete Commissions ----------------------
--SELECT * FROM Commission 
--DELETE Commission
--WHERE CompanyID = 7 AND CommDate >= @BonusDate and amount > 0
-- Delete Commissions ----------------------
--SELECT * FROM Payout 
--DELETE Payout
--WHERE CompanyID = 7 AND PayDate >= @BonusDate
--SELECT * FROM Payment 
--DELETE Payment
--WHERE PayDate >= @BonusDate AND PayType = 90 and notes like 'Intro%'


-- ***********************************************
-- Mark Qualified to receive a check
-- ***********************************************
-- ***** START by marking all members not qualified *****
--UPDATE Member SET Qualify = 1 WHERE CompanyID = 7

-- ***** Check for a verified Payout ACH or a Paper Check *****
--UPDATE me SET Qualify = 2
--SELECT * 
FROM Member AS me
LEFT OUTER JOIN Billing AS b2 ON me.PayID = b2.BillingID
WHERE me.CompanyID = 7
AND ( b2.Verified = 2 OR b2.commtype = 3 )

-- ***** Mark International NOT Qualified to receive a check ***********
--UPDATE me SET Qualify = 1
--select me.qualify,*
FROM Member AS me
LEFT OUTER JOIN Address AS aa ON me.MemberID = aa.OwnerID
where me.companyid = 7 and aa.countryid != 224

-- ***** Mark Unprocessed Payments NOT Qualified to receive a check ***********
UPDATE me SET Qualify = 1
--select pa.* 
FROM Member AS me
LEFT OUTER JOIN Payment AS pa ON me.MemberID = pa.OwnerID
WHERE me.CompanyID = 7 AND pa.Status = 0 AND me.Qualify = 2

-- ***** Levels 1 -3 dont get checks
UPDATE me SET Qualify = 1
--select * 
FROM Member AS me
WHERE me.CompanyID = 7 AND title >= 11 and Title <= 13 AND me.Qualify = 2

-- List payouts to be paid 
SELECT SUM(Amount) FROM (
	SELECT me.MemberID, me.NameFirst, me.NameLast, me.email, SUM(Amount)'Amount' FROM Payout AS pa
	JOIN Member AS me ON pa.OwnerID = me.MemberID
--	JOIN billing AS bi ON bi.BillingID = me.PayID
	WHERE me.CompanyID = 7 AND pa.Status = 1
	AND me.qualify = 2
--	AND bi.commtype = 2
	GROUP BY me.MemberID, me.NameFirst, me.NameLast, me.email 
	Having SUM(Amount) >= 20
--	ORDER BY SUM(Amount) DESC
)tmp

-- List all people with $20+ earned and unqualified to receive a check 
SELECT me.MemberID, me.NameFirst, me.NameLast, me.email, me.title, bi.paytype, bi.verified, b2.commtype, b2.verified, aa.countryid, SUM(Amount)'Amount' FROM Payout AS pa
JOIN Member AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.BillingID = bi.BillingID
left outer JOIN Billing AS b2 ON me.PayID = b2.BillingID
LEFT OUTER JOIN Address AS aa ON me.MemberID = aa.OwnerID
WHERE me.CompanyID = 7 AND pa.Status = 1
AND me.qualify = 1
GROUP BY me.MemberID, me.NameFirst, me.NameLast, me.email, me.title, bi.paytype, bi.verified, b2.commtype, b2.verified, aa.countryid 
Having SUM(Amount) >= 20
ORDER BY SUM(Amount) DESC

-- List members who were auto-upgraded
select * from payout where reference like '%Upgrade%' order by ownerid

-- Mark Qualified to receive a check, if they don't have a declined payment
--SELECT *
UPDATE me SET Qualify = 1
FROM Member AS me
LEFT OUTER JOIN Billing AS b1 ON me.BillingID = b1.BillingID
WHERE me.CompanyID = 7 AND b1.PayType = 1
AND me.qualify = 2

-- Mark Payouts Paid
--UPDATE pa SET Status = 2, PaidDate = '6/16/11', PayType = 1 
--SELECT * 
FROM Payout AS pa
JOIN Member AS me ON pa.OwnerID = me.MemberID
WHERE pa.Status = 1 AND me.MemberID IN (87555,87101,87926,87273)

