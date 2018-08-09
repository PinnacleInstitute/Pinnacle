EXEC [dbo].pts_CheckProc 'pts_Pinnacle_CountSponsor'
GO

--declare @Result varchar(1000) EXEC pts_Pinnacle_CountSponsor 521, 1, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Pinnacle_CountSponsor
   @MemberID int ,
   @Sponsor int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

IF @Sponsor = 1
BEGIN
	SELECT @Result = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Status <= 5
END

IF @Sponsor = 2
BEGIN
	SELECT @Result = COUNT(*) FROM Member WHERE Sponsor2ID = @MemberID AND Status <= 5
END

IF @Sponsor = 3
BEGIN
	SELECT @Result = COUNT(*) FROM Member WHERE Sponsor3ID = @MemberID AND Status <= 5
END

GO
