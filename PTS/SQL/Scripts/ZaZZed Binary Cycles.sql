--List all members with binary volume on both sieds that have at least 2 personal enrollees

select me.memberid, me.namefirst, me.namelast, me0.qv4 'Left', me1.qv4 'Right' from Member as me
left outer join Member as me0 on me.MemberID = me0.Sponsor3ID and me0.Pos = 0 and me0.Status >= 1 and me0.Status <= 4 
left outer join Member as me1 on me.MemberID = me1.Sponsor3ID and me1.Pos = 1 and me1.Status >= 1 and me1.Status <= 4 
where me.companyid = 9 and me0.QV4 > 0 and me1.QV4 > 0
and 2 <= (select COUNT(*) from Member where ReferralID = me.MemberID and Status >= 1 and Status <= 4 and Title >= 4)
order by me.MemberID


--DECLARE @Count int EXEC pts_Commission_Company_9b 8888, 0, '', @Count OUTPUT PRINT @Count

