-- *****************************************************************************
-- BUILDER PROMOTION: $100 for Any Affiliate that recruits 6 Affiliates 
-- From: 5/2/12 at 8:00pm to Midnight on May, 9, 2012. 
-- *****************************************************************************
select MemberID, Title, NameFirst, NameLast from Member AS me
WHERE Status >= 1 AND Status <= 4 AND Level = 1 AND GROUPID <> 100
and (Select COUNT(*) from Member where ReferralID = me.MemberID and Title >= 2 and EnrollDate >= '5/2/12' and EnrollDate < '5/10/12') > 6 




