EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_11_Promote'
GO

--SELECT Title2, MinTitle, TitleDate, Title FROM Member WHERE MemberID = 7238
--DECLARE @Count int EXEC pts_Commission_CalcAdvancement_11_Promote 7238, 3, 0, 0, 0, @Count OUTPUT PRINT @Count
--select title, title2, maxmembers from member where memberid=572

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_11_Promote
	@MemberID int, 
	@PayTitle int, 
	@MinTitle int, 
	@TitleDate datetime, 
	@PermTitle int, 
    @EnrollDate datetime,
	@Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Today datetime, @MaxTitle int, @NewTitle int
DECLARE @Qualify int, @cnt int, @ID int, @IsEarned bit

SET @Today = GETDATE()
SET @Count = 0
SET @MaxTitle = 7
IF @EnrollDate > 0 SET @Today = @EnrollDate

SET @NewTitle = @PayTitle
SET @Qualify = 1
SET @cnt = 0

--Check for a title promotion
WHILE @Qualify = 1 AND @NewTitle < @MaxTitle
BEGIN
	SET @NewTitle = @PayTitle + ( @cnt + 1 )
--	-- Check if member meets the next recruiting requirement, if so, check next titles 
	EXEC pts_Commission_CalcAdvancement_11_Test @MemberID, @NewTitle, @EnrollDate, @Qualify OUTPUT
--	-- If member advances check for next title promotion, otherwise rollback to last good title
	IF @Qualify = 1
		SET @cnt = @cnt + 1
	ELSE
		SET @NewTitle = @NewTitle - 1
END

--	If we have a new title or a higher minimum title, store and log the change
IF @NewTitle != @PayTitle OR @MinTitle > @NewTitle
BEGIN
	IF @MinTitle > @NewTitle
	BEGIN
		SET @IsEarned = 0
		SET @NewTitle = @MinTitle
	END
	ELSE
		SET @IsEarned = 1

--	-- Check if we have a new highest title
	IF @NewTitle > @PermTitle SET @PermTitle = @NewTitle
	
--	-- Update the affiliate's permenant and pay titles
	UPDATE Member SET Title = @PermTitle, Title2 = @NewTitle WHERE MemberID = @MemberID

--	-- MemberTitleID,MemberID,TitleDate,Title,IsEarned,UserID
	EXEC pts_MemberTitle_Add @ID, @MemberID, @EnrollDate, @NewTitle, @IsEarned, 1
	SET @Count = 1

--	-- If this member was promoted, Check if his Referrer can be promoted
	IF @NewTitle > @PayTitle
	BEGIN
		DECLARE @ReferralID int
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		EXEC pts_Commission_CalcAdvancement_11 @ReferralID, @EnrollDate, @cnt OUTPUT
	END	
END

GO
