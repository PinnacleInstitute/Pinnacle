----------------------------------------------
-- GCR TEST QUERIES
----------------------------------------------

---------------------------------------------------------------------------
-- Check for recent payout method changes for the specified member
---------------------------------------------------------------------------
DECLARE @MemberID int, @AuditDate datetime
SET @MemberID =  22316
SET @AuditDate = '12/1/14'
select * from Audit AS ad left outer join AuthUser as au on ad.AuthUserID = au.authuserid
where Page like '%MemberID=' + CAST(@MemberID as varchar(10)) + '%' and Page like '%2913%' and IP <> '' and AuditDate > @AuditDate order by AuditDate desc

------------------------------------------------------------------------------------------
-- Check for any member with a payout today and their payout method was changed recently 
-- by someone other than the member or the system admin
------------------------------------------------------------------------------------------
DECLARE @Today datetime, @AuditDate datetime
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @AuditDate = '12/1/14'
SELECT * FROM Member AS me
WHERE me.CompanyID = 17
AND 0 < (SELECT SUM(Amount) FROM Payout WHERE OwnerID = me.MemberID AND PaidDate = @Today)
AND 1 < (
	SELECT COUNT(a.IP) FROM (
		SELECT IP, COUNT(*) cnt FROM Audit
		WHERE Page LIKE '%MemberID=' + CAST(me.MemberID as varchar(10)) + '%' 
		AND Page LIKE '%2913%'
		AND AuthUserID <> 1
		AND IP <> ''
		AND AuditDate > @AuditDate
		GROUP BY IP
	) a
)

---------------------------------------------------------------------------
--U.S. Members with $600+ Earning and NO Tax ID
---------------------------------------------------------------------------
select memberid, namefirst, namelast, Email from Member as me
where CompanyID = 17
and 0 < (select COUNT(*) from Address where OwnerID = me.MemberID and CountryID = 224)
and 600 <= (select SUM(Amount) from Payout where OwnerID = me.MemberID and Amount > 0)
and 0 = (select COUNT(*) from Govid where MemberID = me.MemberID and GType IN (1,2) and GNumber <> '')

---------------------------------------------------------------------------
--List all Missing Wallets
---------------------------------------------------------------------------
select MemberID, me.NameFirst, me.NameLast, enrolldate, au.Logon, au.password 
from Member as me join AuthUser as au on me.AuthUserID = au.AuthUserID where CompanyID = 17 and Status = 1 and Reference = ''

---------------------------------------------------------------------------
--List all payment mining order errors
---------------------------------------------------------------------------
select paymentid, OwnerID, paiddate, purpose, Amount 
from Payment where CompanyID = 17 and Notes like '%sorry%'

