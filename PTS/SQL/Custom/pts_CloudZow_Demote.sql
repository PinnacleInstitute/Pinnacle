EXEC [dbo].pts_CheckProc 'pts_CloudZow_Demote'
GO

--DECLARE @Count int EXEC pts_CloudZow_Demote 2734, @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_CloudZow_Demote
   @MemberID int ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @PayTitle int, @MinTitle int, @TitleDate datetime, @PermTitle int, @Sales money, @BV money, @cnt int
SET @CompanyID = 5
SET @Count = 0

IF @MemberID > 0
BEGIN
	SELECT @PayTitle = Title2, @MinTitle = MinTitle, @TitleDate = TitleDate, @PermTitle = Title, @Sales = QV FROM Member WHERE MemberID = @MemberID
--	-- Only if Bonus Qualified,  Check if we can promote / demote this affiliate
	IF @PayTitle > 1
		EXEC pts_Commission_CalcAdvancement_5_Demote @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @Sales, @Count OUTPUT
END
ELSE
BEGIN
--	-- *************************************************************************************************
--	-- Calculate the title advancements for each member, Process all active members up to highest title
--	-- *************************************************************************************************
	DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID, Title2, MinTitle, TitleDate, Title, QV FROM Member
	WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 4

	OPEN Member_Cursor
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @Sales
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		-- If Affiliate of higher, Check if we can demote this affiliate
		IF @PayTitle > 1
		BEGIN
			SET @cnt = 0
			EXEC pts_Commission_CalcAdvancement_5_Demote @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @Sales, @cnt OUTPUT
			IF @cnt > 0 SET @Count = @Count + @cnt
		END
		
		FETCH NEXT FROM Member_Cursor INTO @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @Sales
	END
	CLOSE Member_Cursor
	DEALLOCATE Member_Cursor
END

GO
