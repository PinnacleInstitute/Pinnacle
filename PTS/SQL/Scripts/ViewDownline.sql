DECLARE @CompanyID int, @MemberID int
SET @CompanyID = 14
SET @MemberID = 10775

DECLARE @Temp TABLE(
   MemberID int
)

WITH Members (CompanyID, MemberID, GRoupID, Levels)
AS
(
--	Anchor member definition
	SELECT me.CompanyID, me.MemberID, me.GroupID, 0 AS Levels 
	FROM Member AS me
	WHERE MemberID = @MemberID
	UNION ALL
--	Recursive member definition
	SELECT me.CompanyID, me.MemberID, me.GroupID, Levels + 1
	FROM Member AS me
	INNER JOIN Members AS ms ON me.Sponsor3ID = ms.MemberID
)
--	Statement that executes the CTE
INSERT INTO @Temp
Select MemberID
--Select MemberID, GroupID
FROM Members AS me
WHERE me.CompanyID = @CompanyID
AND me.Levels <= 10000
ORDER BY me.MemberID 
OPTION (MAXRECURSION 0) 

UPDATE Member SET GroupID = @MemberID
WHERE MemberID IN ( SELECT MemberID FROM @Temp )

