DECLARE @CompanyID int, @MemberID int
SET @CompanyID = 21
SET @MemberID = 38347

	WITH Members (CompanyID, MemberID, ReferralID, Status, Level, NameFirst, NameLast, Email, Phone1, Levels)
	AS
	(
--		Anchor member definition
		SELECT me.CompanyID, me.MemberID, me.ReferralID, me.Status, me.Level, me.NameFirst, me.NameLast, me.Email, me.Phone1, 0 AS Levels 
		FROM Member AS me
		WHERE MemberID = @MemberID
		UNION ALL
--		Recursive member definition
		SELECT me.CompanyID, me.MemberID, me.ReferralID, me.Status, me.Level, me.NameFirst, me.NameLast, me.Email, me.Phone1, Levels + 1
		FROM Member AS me
		INNER JOIN Members AS ms
			ON me.ReferralID = ms.MemberID
	)
--	Statement that executes the CTE
	Select MemberID, NameLast, NameFirst, Email, Phone1 
	FROM Members AS me
	
	WHERE me.CompanyID = @CompanyID AND me.Status IN (1,4)
	AND me.Levels <= 10000
	ORDER BY me.MemberID 
	OPTION (MAXRECURSION 0) 
