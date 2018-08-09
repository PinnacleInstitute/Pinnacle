declare @MemberID int, @Manager int, @Director int, @Executive int
declare @L1 money, @L2 money, @L3 money
DECLARE @T1 money, @T2 money, @T3 money, @T4 money, @T5 money, @T6 money, @T7 money, @T8 money
SET @MemberID = 606

print '***************************'
print 'Bonus Potential '
print 'for member #' + CONVERT(varchar(20), @MemberID)
print '***************************'

select @Manager = COUNT(*) from Downline AS dn
join member as me on dn.ChildID = me.memberid
where Line = 2 and ParentID = @MemberID and Level = 1
SET @L1 = @Manager * 4
select @Director = COUNT(*) from Downline AS dn
join member as me on dn.ChildID = me.memberid
where Line = 3 and ParentID = @MemberID and Level = 1
SET @L2 = @Director * 2
select @Executive = COUNT(*) from Downline AS dn
join member as me on dn.ChildID = me.memberid
where Line = 4 and ParentID = @MemberID and Level = 1
SET @L3 = @Executive * 2


-- ***********************************************
-- TEAM BONUSES
-- ***********************************************
--	1st Level Team Bonus
-- ***********************************************
	SELECT @T1 = COUNT(A.MemberID) * 4 
	FROM Member As A
	WHERE A.SponsorID = @MemberID AND A.Level = 1

-- ***********************************************
--	2nd Level Team Bonus
-- ***********************************************
	SELECT @T2 = COUNT(B.MemberID) * 2 
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	WHERE A.SponsorID = @MemberID AND B.Level = 1

-- ***********************************************
--	3rd Level Team Bonus
-- ***********************************************
	SELECT @T3 = COUNT(C.MemberID) * 2 
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	WHERE A.SponsorID = @MemberID AND C.Level = 1

-- ***********************************************
--	4th Level Monthly Bonus
-- ***********************************************
	SELECT @T4 = COUNT(D.MemberID) * 2 
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	JOIN Member AS D ON C.MemberID = D.SponsorID
	WHERE A.SponsorID = @MemberID AND D.Level = 1

-- ***********************************************
--	5th Level Team Bonus
-- ***********************************************
	SELECT @T5 = COUNT(E.MemberID) * 2 
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	JOIN Member AS D ON C.MemberID = D.SponsorID
	JOIN Member AS E ON D.MemberID = E.SponsorID
	WHERE A.SponsorID = @MemberID AND E.Level = 1

-- ***********************************************
--	6th Level Team Bonus
-- ***********************************************
	SELECT @T6 = COUNT(F.MemberID) * 2 
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	JOIN Member AS D ON C.MemberID = D.SponsorID
	JOIN Member AS E ON D.MemberID = E.SponsorID
	JOIN Member AS F ON E.MemberID = F.SponsorID
	WHERE A.SponsorID = @MemberID AND F.Level = 1

-- ***********************************************
--	7th Level Team Bonus
-- ***********************************************
	SELECT @T7 = COUNT(G.MemberID) * 2 
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	JOIN Member AS D ON C.MemberID = D.SponsorID
	JOIN Member AS E ON D.MemberID = E.SponsorID
	JOIN Member AS F ON E.MemberID = F.SponsorID
	JOIN Member AS G ON F.MemberID = G.SponsorID
	WHERE A.SponsorID = @MemberID AND G.Level = 1

SET @T8 = @T1+@T2+@T3+@T4+@T5+@T6+@T7


print 'Bonus Potential'
print '---------------'
print 'Team Bonus: ' + CAST(@T8 as varchar(10))
print 'Manager Team: ' + CAST(@Manager as varchar(10))
print 'Manager Bonuses: ' + CAST(@L1 as varchar(10))
print 'Director Team: ' + CAST(@Director as varchar(10))
print 'Director Bonuses: ' + CAST(@L2 as varchar(10))
print 'Executive Bonuses: ' + CAST(@Executive as varchar(10))
print 'Executive Bonuses: ' + CAST(@L3 as varchar(10))
print 'Total Leadership Bonus: ' + CAST(@L1+@L2+@L3 as varchar(10))
print 'TOTAL BONUSES: ' + CAST(@T8+@L1+@L2+@L3 as varchar(10))
print ''
