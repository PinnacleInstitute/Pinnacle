EXEC [dbo].pts_CheckProc 'pts_Member_ActiveCount'
GO

CREATE PROCEDURE [dbo].pts_Member_ActiveCount
   @CompanyID int ,
   @MasterID int ,
   @MasterMembers int OUTPUT
AS

SET NOCOUNT ON

DECLARE @MaxMembers int
SET @MaxMembers = 0
SET @MasterMembers = 0

IF @MasterID > 0
BEGIN
	SELECT @MaxMembers = MaxMembers FROM Member WHERE MemberID = @MasterID
	IF @MaxMembers > 0
	BEGIN
		SELECT @MasterMembers = COUNT(*) FROM Member WHERE MasterID = @MasterID AND Status = 1 AND IsRemoved = 0
		IF @MasterMembers > @MaxMembers SET @MasterMembers = @MasterMembers * -1
	END
END

IF @MasterID = 0 OR @MaxMembers = 0
BEGIN
	SELECT @MaxMembers = MemberLimit FROM Coption WHERE CompanyID = @CompanyID
	IF @MaxMembers > 0
	BEGIN
		SELECT @MasterMembers = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND Status = 1 AND IsRemoved = 0
		IF @MasterMembers > @MaxMembers SET @MasterMembers = @MasterMembers * -1
	END
END

GO