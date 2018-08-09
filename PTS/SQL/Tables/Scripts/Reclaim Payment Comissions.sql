-- *********************************
-- Reclaim Returned Payments
-- *********************************
DECLARE @CompanyID int
SET @CompanyID = 5

-- Display all return payments
select me.memberid, me.namelast, me.namefirst, pa.paymentid, pa.paiddate, pa.amount, ad.street1, ad.city, ad.state, ad.zip 
from payment as pa
join member as me on pa.ownerid = me.memberid
left outer join address as ad on me.memberid = ad.ownerid and ad.addresstype = 2
where me.companyid = @CompanyID and pa.status = 5
order by pa.paiddate

-- Get all payments for the specified member #
select pa.paymentid, me.namelast, me.namefirst, pa.amount, pa.status, pa.commdate 
from payment as pa
join member as me on pa.ownerid = me.memberid
where me.memberid = 88061

-- Get all commissions for the specified payment #
select co.commissionid, me.memberid, me.namelast, me.namefirst, co.amount, co.commtype, co.commdate 
from commission as co
join member as me on co.ownerid = me.memberid
where refid = 29778

-- Return paid commissions for membership refunds
DECLARE @Today datetime
SET @Today = '7/13/11'
INSERT INTO Commission ( CompanyID, OwnerType, OwnerID, RefID, CommDate, CommType, Status, Amount, Total, Description )
SELECT                   CompanyID, OwnerType, OwnerID, RefID, @Today, Commtype, 1, Amount*-1, Total*-1, Description FROM Commission
WHERE refid = 29778

