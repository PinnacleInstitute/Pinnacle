EXEC [dbo].pts_CheckProc 'pts_Downline_GetCustom'
GO

CREATE PROCEDURE [dbo].pts_Downline_GetCustom
   @CompanyID int ,
   @Status int ,
   @Line int ,
   @ParentID int ,
   @Dec int OUTPUT ,
   @Old int OUTPUT
AS

SET NOCOUNT ON

IF @CompanyID = 14
BEGIN
	IF @Status = 1
	BEGIN
		SELECT @Dec = COUNT(*) 
		FROM Downline AS dl
		JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = @Line 
		AND dl.ParentID = @ParentID
		AND me.Status = 1
		AND me.Qualify > 1
		AND me.Title >= 5
		AND me.ReferralID = @ParentID

		SELECT @Old = COUNT(*) 
		FROM Downline AS dl
		JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = @Line 
		AND dl.ParentID = @ParentID
		AND me.Status = 1
		AND me.Qualify > 1
		AND me.Title >= 5
	END
END

GO