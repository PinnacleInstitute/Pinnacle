select * from Audit where Page like '%12638%'
select * from Audit where Page like '%13952%'
select * from Audit where Page like '%12616%'
select * from Audit where Page like '%12658%'
select * from Audit where Page like '%13513%'
select * from Audit where Page like '%12620%'
select * from Audit where Page like '%12811%' --Rob 8/14/14 15:40:31
select * from Audit where Page like '%12605%' --Rob 8/14/14 16:01:43

-- AuthUser #12464 changed 22 payout methods
select * from Audit where authuserid = 12464 order by auditid

--AuthUserID #12464 was not a member. (#12463 = Member #14224, and #12465 = Member #14225)
--Per the IIS Logs, OrgID #72 was created on 8/13/14 16:51:24 and deleted on 8/14/14 11:20:04
--OrgID #72 had AuthUserID #12464 per create times of surrounding records
-- by 2 IP Addresses, 83.187.134.100 and 90.130.43.165 in Estonia belonging to Rob
--Rob logged into his member account #12047 with IP Address 83.187.134.100 on 2014-08-13 15:07:00
--Rob logged into his member account #12047 with IP Address 83.187.134.100 on 2014-08-14 11:38:55



select * from Org order by OrgID desc

select * from member where MemberID = 13157

select * from authuser where authuserid=10976
--12638
--AuthUser 10977 Rob
--AuthUser #12464 Created between 11:45:43 and 12:35:05 on 8/13/14

select * from AuthUser where authuserid in (10853,10095,12464)
select * from AuthUser where authuserid in (10871,12462,12463,12464,12465,12366)
select EnrollDate, * from Member where authuserid in (10871,12462,12463,12464,12465,12366)

--[10:53:00 AM] sasa': Cristina Muñoz FErraro  (#12638)
-- Rafael Enriquez aumesquest  (#13952)
--Carlos Lagoa Fernández  -   # 12616 
-- Jaume Celma Povill  (#12658)
--Maribel Povill Bertomeu  (#13513)
--José Abril Reyes  (#12620)
--# 12811 - Inese Ozdemire
--Carlos Garrido Delgado  (#12605)..

select memberid, namefirst, namelast from Member 
where MemberID in (13157,12620,12616,12658,12553,12551,12576,13904,13952,13759,12713,13682,12936,12882,12638,13401,13619,13620,12592,13513,13546,12711)

--select SUM(Amount) from Payout 
--select * from Payout 
select OwnerID,amount from Payout 
where OwnerID in (13157,12620,12616,12658,12553,12551,12576,13904,13952,13759,12713,13682,12936,12882,12638,13401,13619,13620,12592,13513,13546,12711)
and PaidDate = '8/15/14'
--and OwnerID != 12551
order by ownerid
select ownerid,amount from Payout

select me.memberid, me.namefirst, me.NameLast, me.email,cardname from billing as bi
join Member as me on bi.BillingID = me.PayID
where me.MemberID in (13157,12620,12616,12658,12553,12551,12576,13904,13952,13759,12713,13682,12936,12882,12638,13401,13619,13620,12592,13513,13546,12711)
order by MemberID
