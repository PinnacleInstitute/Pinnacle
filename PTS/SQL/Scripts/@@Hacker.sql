--Hacker Queries
-------------------------------------------------------------------------------------------------------
-- Check for recent payout method changes for the specified member
-------------------------------------------------------------------------------------------------------
DECLARE @MemberID int, @AuditDate datetime
SET @MemberID = 19964
SET @AuditDate = '11/15/14'
select * from Audit AS ad left outer join AuthUser as au on ad.AuthUserID = au.authuserid
where Page like '%MemberID=' + CAST(@MemberID as varchar(10)) + '%' and Page like '%2913%' and IP <> '' and AuditDate > @AuditDate order by AuditDate desc
-------------------------------------------------------------------------------------------------------
-- Check for any member with a payout today and their payout method was changed since 11/1/14
-- by someone other than the member or the system admin
-------------------------------------------------------------------------------------------------------
DECLARE @Today datetime, @AuditDate datetime
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @AuditDate = '11/15/14'
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
-------------------------------------------------------------------------------------------------------

--Search for a member's page change
select * from Audit where Page like '%MemberID=13073%' order by AuditDate desc
select * from AuthUser where AuthUserID = 12994

select * from Audit where authuserid = 1 and AuditDate > '10/16/14' order by Authuserid

--Search for changes by any admin
select * from Audit where authuserid in (12352) and auditdate > '9/26/14' and Page like '%2913%' order by auditdate
select * from Audit where auditdate > '9/26/14' and Page like '%2913%' order by auditdate
select 1600*9

--List all admins
select authuserid, NameFirst, namelast from Org where companyid = 17

--14113,14943,14808,15003

--Lookup a specific authuser
select * from AuthUser where AuthUserID in (select authuserid from Audit where authuserid = 1 and auditdate > '9/26/14' and Page like '%2913%')
select * from AuthUser where AuthUserID in (8925,13052)
select * from Member where MemberID in (14113,14943,14808,15003)

select bi.* from Billing as bi
join Member as me on bi.BillingID = me.payid
where me.MemberID in (14113) 
--where me.MemberID in (13104,12818,13341,13332,13333,13184,13186,13182,13153,14440,14113,14429,12824,13649,13021,13058,13098,13095,13037)

select * from Org where companyid != 171 order by orgid desc
select EnrollDate,* from Member where authuserID in (12879,12880,12881,10284,10242)