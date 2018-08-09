EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_8_Promote'
GO

--DECLARE @Count int EXEC pts_Commission_CalcAdvancement_8_Promote 5203, 4, 0, 0, 0, 0, 0, @Count OUTPUT PRINT @Count
--select title, title2, maxmembers from member where memberid=572

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_8_Promote
	@MemberID int, 
	@PayTitle int, 
	@MinTitle int, 
	@TitleDate datetime, 
	@PermTitle int, 
	@Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Today datetime, @MaxTitle int, @NewTitle int
DECLARE @Qualify int, @cnt int, @ID int, @IsEarned bit

SET @Today = GETDATE()
SET @Count = 0
SET @MaxTitle = 3

SET @NewTitle = @PayTitle
SET @Qualify = 1
SET @cnt = 0

--Check for a title promotion
WHILE @Qualify = 1 AND @NewTitle < @MaxTitle
BEGIN
	SET @NewTitle = @PayTitle + ( @cnt + 1 )
--	-- Check if member meets the next recruiting requirement, if so, check next titles 
	EXEC pts_Commission_CalcAdvancement_8_Test @MemberID, @NewTitle, @Qualify OUTPUT
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
	EXEC pts_MemberTitle_Add @ID, @MemberID, @Today, @NewTitle, @IsEarned, 1
	SET @Count = 1
	
--	-- If this member was promoted to a Senior Coach, Test If his Referrer can be promoted
	IF @NewTitle = 2
	BEGIN
		DECLARE @ReferralID int
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		EXEC pts_Commission_CalcAdvancement_8 @ReferralID, @cnt OUTPUT
	END	
END

GO
