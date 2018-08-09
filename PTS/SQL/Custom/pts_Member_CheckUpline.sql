EXEC [dbo].pts_CheckProc 'pts_Member_CheckUpline'
GO

--declare @Result int EXEC pts_Member_CheckUpline 12045, 12551, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Member_CheckUpline
   @SponsorID int ,
   @MemberID int ,
   @Status int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @UplineID int, @Line int
SET @UplineID = @SponsorID
SET @Line = @Status
SET @Result = 0

IF @Line = 1
BEGIN
	WHILE @MemberID > 0
	BEGIN
		SET @SponsorID = 0
		SELECT @SponsorID = ReferralID FROM Member WHERE MemberID = @MemberID
		IF @SponsorID = @UplineID
		BEGIN
			SET @Result = 1
			SET @SponsorID = 0
		END	
		SET @MemberID = @SponsorID
	END
END

IF @Line = 2
BEGIN
	WHILE @MemberID > 0
	BEGIN
		SET @SponsorID = 0
		SELECT @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
		IF @SponsorID = @UplineID
		BEGIN
			SET @Result = 1
			SET @SponsorID = 0
		END	
		SET @MemberID = @SponsorID
	END
END

GO