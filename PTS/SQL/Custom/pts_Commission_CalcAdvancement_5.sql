EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_5'
GO

--DECLARE @Count int EXEC pts_Commission_CalcAdvancement_5 0, @Count OUTPUT PRINT @Count
--DECLARE @Count int EXEC pts_Commission_CalcAdvancement_5 5203, 0, @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_5
   @MemberID int ,
   @EnrollDate datetime,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @MaxTitle int, @PayTitle int, @MinTitle int, @TitleDate datetime, @PermTitle int, @Sales money, @BV money, @cnt int
SET @CompanyID = 5
SET @Count = 0
SET @MaxTitle = 6

IF @MemberID > 0
BEGIN
	SELECT @PayTitle = Title2, @MinTitle = MinTitle, @TitleDate = TitleDate, @PermTitle = Title, @BV = QV, @Sales = QV FROM Member WHERE MemberID = @MemberID
--	-- Only if Bonus Qualified,  Check if we can promote / demote this affiliate
	IF @BV >= 40
	BEGIN
		EXEC pts_Commission_CalcAdvancement_5_Promote @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @Sales, @EnrollDate, @Count OUTPUT
	END	
END
ELSE
BEGIN
--	-- *************************************************************************************************
--	-- Calculate the title advancements for each member, Process all active members up to highest title
--	-- *************************************************************************************************
	DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID, Title2, MinTitle, TitleDate, Title, QV, BV FROM Member
	WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND Title2 <= @MaxTitle

	OPEN Member_Cursor
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @Sales, @BV
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		-- Only if Bonus Qualified,  Check if we can promote / demote this affiliate
		IF @BV >= 40 
		BEGIN
			SET @cnt = 0
			EXEC pts_Commission_CalcAdvancement_5_Promote @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @Sales, @EnrollDate, @cnt OUTPUT
			IF @cnt > 0 SET @Count = @Count + @cnt
		END
		
		FETCH NEXT FROM Member_Cursor INTO @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @Sales, @BV
	END
	CLOSE Member_Cursor
	DEALLOCATE Member_Cursor
END

GO
