-- **************************************
-- Caclulate Promotions
-- **************************************
declare @MemberID int, @cnt int, @Count int
SET @Count = 0

DECLARE Member_cursor CURSOR FOR 
SELECT MemberID
FROM Member WHERE CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5
AND memberid = 521

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
--	check for advancement for this affiliate
	SET @cnt = 0
	EXEC pts_Commission_CalcAdvancement_5 @MemberID, @cnt OUTPUT
	IF @cnt > 0 SET @Count = @Count + @cnt

	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

PRINT @Count
