EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_18'
GO

--DECLARE @Count int EXEC pts_Commission_CalcAdvancement_18 0, 0, @Count OUTPUT PRINT @Count
--DECLARE @Count int EXEC pts_Commission_CalcAdvancement_18 10733, 0, @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_18
   @MemberID int ,
   @EnrollDate datetime,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @MaxTitle int, @PayTitle int, @MinTitle int, @TitleDate datetime, @PermTitle int, @cnt int
SET @CompanyID = 18
SET @MaxTitle = 10
SET @Count = 0

IF @MemberID > 0
BEGIN
	SELECT @PayTitle = Title, @MinTitle = MinTitle, @TitleDate = TitleDate, @PermTitle = Title FROM Member WHERE MemberID = @MemberID
	EXEC pts_Commission_CalcAdvancement_18_Promote @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @EnrollDate, @Count OUTPUT
END
ELSE
BEGIN
--	-- *************************************************************************************************
--	-- Calculate the title advancements for each member, Process all active members up to highest title
--	-- *************************************************************************************************
	DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID, Title, MinTitle, TitleDate, Title FROM Member
	WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND Title < @MaxTitle

	OPEN Member_Cursor
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @cnt = 0
		EXEC pts_Commission_CalcAdvancement_18_Promote @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle, @EnrollDate, @cnt OUTPUT
		IF @cnt > 0 SET @Count = @Count + @cnt
		
		FETCH NEXT FROM Member_Cursor INTO @MemberID, @PayTitle, @MinTitle, @TitleDate, @PermTitle
	END
	CLOSE Member_Cursor
	DEALLOCATE Member_Cursor
END

GO
