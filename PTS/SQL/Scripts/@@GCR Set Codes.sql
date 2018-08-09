DECLARE @CompanyID int, @MemberID int, @D1 int, @D2 int, @D3 int
SET @CompanyID = 17
SET @MemberID = 12574
SET @D1 = 0
SET @D2 = 12556
SET @D3 = 0

--select * from member where memberid = 12574

DECLARE @Temp TABLE(
   MemberID int
)

WITH Members (CompanyID, MemberID, Levels)
AS
(
--	Anchor member definition
	SELECT me.CompanyID, me.MemberID,  0 AS Levels 
	FROM Member AS me
	WHERE MemberID = @MemberID
	UNION ALL
--	Recursive member definition
	SELECT me.CompanyID, me.MemberID, Levels + 1
	FROM Member AS me
	INNER JOIN Members AS ms ON me.ReferralID = ms.MemberID
)
--	Statement that executes the CTE
INSERT INTO @Temp
Select MemberID
FROM Members AS me
WHERE me.CompanyID = @CompanyID
AND me.MemberID != @MemberID
AND me.Levels <= 10000
ORDER BY me.MemberID 
OPTION (MAXRECURSION 0) 

select * from @Temp
--UPDATE Member SET GroupID = @MemberID
--WHERE MemberID IN ( SELECT MemberID FROM @Temp )

IF @D1 > 0
BEGIN
--	SELECT * FROM Downline WHERE Line = 6 AND ChildID = @MemberID
	UPDATE Downline SET ParentID = @D1 WHERE Line = 6 AND ChildID IN ( SELECT MemberID FROM @Temp )
--	and ParentID in (12047)
--	select * from Downline WHERE Line = 6 AND ChildID IN ( SELECT MemberID FROM @Temp )
END
IF @D2 > 0
BEGIN
--	SELECT * FROM Downline WHERE Line = 7 AND ChildID = @MemberID
	UPDATE Downline SET ParentID = @D2 WHERE Line = 7 AND ChildID IN ( SELECT MemberID FROM @Temp )
	and ParentID in (12047)
--	select * from Downline WHERE Line = 7 AND ChildID IN ( SELECT MemberID FROM @Temp )
END
IF @D3 > 0
BEGIN
--	SELECT * FROM Downline WHERE Line = 8 AND ChildID = @MemberID
	UPDATE Downline SET ParentID = @D3 WHERE Line = 8 AND ChildID IN ( SELECT MemberID FROM @Temp )
END
