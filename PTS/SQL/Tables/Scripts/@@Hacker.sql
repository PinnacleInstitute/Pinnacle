--Hacker Queries

--Search for a member's page change
select * from Audit where Page like '%memberid=14420%' order by AuditDate
select * from AuthUser where AuthUserID = 12662

select * from Audit where AuditDate > '9/18/14' order by Authuserid

--Search for changes by any admin
select * from Audit where authuserid in (1,10976,10242,10977,10978,12630,12880) and auditdate > '8/25/14' and Page like '%2913%' order by auditdate

--Search for recent changes to Payout methods
select * from Audit where Page like '%2913%' and Page like '%companyid=17%' order by auditdate desc

--List all admins
select authuserid, NameFirst, namelast from Org where companyid = 17

--Lookup a specific authuser
select * from AuthUser where AuthUserID in (12879,12880,12881,10284,10242)
select * from Member where MemberID in (12046)

select bi.* from Billing as bi
join Member as me on bi.BillingID = me.payid
where me.MemberID in (12638,12715,12811,13443,14166,12556,12644) 
--where me.MemberID in (13104,12818,13341,13332,13333,13184,13186,13182,13153,14440,14113,14429,12824,13649,13021,13058,13098,13095,13037)

select * from Org where companyid != 171 order by orgid desc
select EnrollDate,* from Member where authuserID in (12879,12880,12881,10284,10242)