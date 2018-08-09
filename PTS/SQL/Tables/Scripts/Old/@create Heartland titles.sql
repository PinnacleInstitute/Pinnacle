-- ********************************************************************************************************
-- Assign Member Titles based on QV
-- ********************************************************************************************************
DECLARE @MemberID int, @QV money, @Title int, @TitleDate datetime, @MemberTitleID int
SET @TitleDate = GETDATE()

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, QV
FROM Member WHERE QV > 0 AND CompanyID = 582

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @QV

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Title = 0

	If @QV >= 400    SET @Title = 1
	If @QV >= 1000   SET @Title = 2
	If @QV >= 2500   SET @Title = 3
	If @QV >= 5000   SET @Title = 4
	If @QV >= 7500   SET @Title = 5
	If @QV >= 10000  SET @Title = 6
	If @QV >= 15000  SET @Title = 7
	If @QV >= 20000  SET @Title = 8
	If @QV >= 50000  SET @Title = 9
	If @QV >= 100000 SET @Title = 10

	UPDATE Member SET Title = @Title WHERE MemberID = @MemberID

	EXEC pts_MemberTitle_Add @MemberTitleID, @MemberID, @TitleDate, @Title, 1

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @QV
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor
