EXEC [dbo].pts_CheckProc 'pts_CloudZow_OverDraft'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_OverDraft @Result output print @Result
--select Process, Price, BV, BV2 FROM Member WHERE MemberID = 4704
--UPDATE Member SET Process = 0, Price = 0, BV = 0, BV2 = 0 WHERE MemberID = 4704

CREATE PROCEDURE [dbo].pts_CloudZow_OverDraft
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
DECLARE @MemberID int, @SponsorID int, @BV money, @Computers int, @Price money


DECLARE @Count int, @cnt int
SET @cnt = 0

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, SponsorID, BV FROM Member 
WHERE CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND PromoID > 0 AND BV < 40

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @SponsorID, @BV
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @cnt = @cnt + 1
	SET @BV = 40 - @BV
	SET @Computers = @BV / 5
	SET @Price = @Computers * 5
--print cast(@MemberID as varchar(10)) + ' - ' + cast(@BV as varchar(10))

	UPDATE Member SET Process = @Computers, Price = @Price, BV = 40, BV2 = 40 WHERE MemberID = @MemberID

--	 *************************************************************
--	 Adjust group volume (based on sponsor)
--	 *************************************************************
	SET @MemberID = @SponsorID
	WHILE @MemberID > 0
	BEGIN
		SET @SponsorID = -1
		SELECT @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
--		TEST if we found the affiliate
		IF @SponsorID >= 0
		BEGIN
--			-- adjust the affiliate's group sales volume
			UPDATE Member SET QV = QV + @BV, QV2 = QV2 + @BV WHERE MemberID = @MemberID 

--			-- check for advancement for this affiliate
			EXEC pts_Commission_CalcAdvancement_5 @MemberID, 0, @cnt OUTPUT

			SET @MemberID = @SponsorID
		END
		ELSE SET @MemberID = 0
	END

	FETCH NEXT FROM Member_cursor INTO @MemberID, @SponsorID, @BV
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@cnt AS VARCHAR(10))
