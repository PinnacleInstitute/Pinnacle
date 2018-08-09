EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_5_Promote'
GO

--DECLARE @Count int EXEC pts_Commission_CalcAdvancement_5_Promote 5203, 4, 0, 0, 0, 0, 0, @Count OUTPUT PRINT @Count
--select title, title2, maxmembers from member where memberid=572

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_5_Promote
	@MemberID int, 
	@PayTitle int, 
	@MinTitle int, 
	@TitleDate datetime, 
	@PermTitle int, 
	@Sales money,
    @EnrollDate datetime,
	@Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Today datetime, @MaxTitle int, @NewTitle int, @Maintain int
DECLARE @Qualify int, @cnt int, @ID int, @IsEarned bit

SET @Today = GETDATE()
SET @Count = 0
SET @MaxTitle = 6
IF @EnrollDate > 0 SET @Today = @EnrollDate

SET @NewTitle = @PayTitle
SET @Qualify = 1
SET @cnt = 0

--Check for a title promotion
WHILE @Qualify = 1 AND @NewTitle < @MaxTitle
BEGIN
	SET @NewTitle = @PayTitle + ( @cnt + 1 )
--	-- Check if they have already achieved this title, and must only maintain it now
	IF @PermTitle >= @NewTitle SET @Maintain = 1 ELSE SET @Maintain = 0
--	-- Check if member meets the next recruiting requirement, if so, check next titles 
	EXEC pts_Commission_CalcAdvancement_5_Test @MemberID, @NewTitle, @Maintain, @Sales, @EnrollDate, @Qualify OUTPUT
--	-- If member advances check for next title promotion, otherwise rollback to last good title
--IF @MemberID = 1122
--BEGIN
--	print CAST(@NewTitle as varchar(10)) + ' -- ' + CAST(@Sales as varchar(10)) + ' - ' + CAST(@PromoteDate as varchar(20)) + ' - ' + CAST(@Qualify as varchar(10))
--END
	IF @Qualify = 1
		SET @cnt = @cnt + 1
	ELSE
		SET @NewTitle = @NewTitle - 1
END

	-- If no promotion, check for a title demotion
--IF @NewTitle = @PayTitle AND @NewTitle > 1
--BEGIN
--	-- Check if we have a minimum title locked-in for this member
--	IF @TitleDate > 0 AND @TitleDate < @Today SET @MinTitle = 1

--	SET @Qualify = 0
--	SET @cnt = -1
--	-- Check for a title demotion, don't drop below the minimum title for this member
--	WHILE @Qualify = 0 AND @NewTitle > @MinTitle
--	BEGIN
--		SET @NewTitle = @PayTitle - (@cnt + 1)
--		-- Check if they have already achieved this title, and must only maintain it now
--		IF @PermTitle >= @NewTitle SET @Maintain = 1 ELSE SET @Maintain = 0
--		-- Check if member meets the next recruiting requirement, if so, check next titles 
--		EXEC pts_Commission_CalcAdvancement_5_Test @MemberID, @NewTitle, @Maintain, @Sales, @EnrollDate, @Qualify OUTPUT
--		-- If member fails title promotion test next level down, otherwise rollforward to last good title
--		IF @Qualify = 0 SET @cnt = @cnt + 1
--	END
--END

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

--	-- Update the affiliate's max title if it is lower than their new permenant title
	UPDATE Member SET MaxMembers = @PermTitle WHERE MemberID = @MemberID AND MaxMembers < @PermTitle

--	-- Adjust Upline highest Title
	EXEC pts_Commission_CalcAdvancement_5_Title @MemberID, @NewTitle

--	-- MemberTitleID,MemberID,TitleDate,Title,IsEarned,UserID
	EXEC pts_MemberTitle_Add @ID, @MemberID, @Today, @NewTitle, @IsEarned, 1
	SET @Count = 1

--	-- If this member was promoted, Check if his Referrer can be promoted
	IF @NewTitle > @PayTitle
	BEGIN
		DECLARE @ReferralID int
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		EXEC pts_Commission_CalcAdvancement_5 @ReferralID, @EnrollDate, @cnt OUTPUT
	END	
END

GO
