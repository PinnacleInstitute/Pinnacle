-- *****************************************************************************
-- PRELAUNCH PROMOTION: $50 for Any Affiliate that become Manager with 2 Sr.s 
-- From: 5/9/12 at 8:00pm to Midnight on May, 31, 2012. 
-- *****************************************************************************
select me.MemberID, me.title, me.NameFirst, namelast from MemberTitle as mt
join Member as me on mt.memberid = me.memberid
where mt.TitleDate >= '5/9/12' and mt.TitleDate < '6/1/12' and mt.Title = 4
and (SELECT COUNT(*) FROM Member WHERE ReferralID = mt.MemberID and Status >= 1 and Status <= 4 and Level = 1 and Title >= 3) > 2  



