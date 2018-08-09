EXEC [dbo].pts_CheckProc 'pts_CloudZow_Promote'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_Promote 0, @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_Promote
   @MemberID int,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @SponsorID int, @cnt int, @Count int
SET @Count = 0

UPDATE me 
	SET BV3 = (SELECT COUNT(*) FROM Member WHERE SponsorID = me.MemberID AND [Level] = 1 AND Status >= 1 AND Status <= 4)
FROM Member AS me WHERE me.CompanyID = 5 AND [Level] = 1 AND me.Status >= 1 AND me.Status <= 5

DECLARE Member_cursor CURSOR FOR 
SELECT MemberID
FROM Member WHERE CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5
AND ( ( @MemberID = 0 AND BV3 = 0 ) OR MemberID = @MemberID )

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	WHILE @MemberID > 0
	BEGIN
		SET @SponsorID = -1
		SELECT @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
--		-- TEST if we found the affiliate
		IF @SponsorID >= 0
		BEGIN
--			-- check for advancement for this affiliate
			SET @cnt = 0
			EXEC pts_Commission_CalcAdvancement_5 @MemberID, 0, @cnt OUTPUT
			IF @cnt > 0 SET @Count = @Count + @cnt

			SET @MemberID = @SponsorID
		END
		ELSE SET @MemberID = 0
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@Count AS VARCHAR(10))

GO