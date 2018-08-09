EXEC [dbo].pts_CheckProc 'pts_Member_DeleteMaster'
GO

CREATE PROCEDURE [dbo].pts_Member_DeleteMaster
   @MemberID int
AS

SET         NOCOUNT ON

DECLARE @IsMaster bit

SELECT @IsMaster = IsMaster FROM Member WHERE MemberID = @MemberID

IF @IsMaster = 1
BEGIN
	UPDATE Member SET Billing = 3 WHERE MasterID = @MemberID AND Billing = 4
	UPDATE Member SET MasterID = 0 WHERE MasterID = @MemberID
END

GO