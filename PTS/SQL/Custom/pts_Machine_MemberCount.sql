EXEC [dbo].pts_CheckProc 'pts_Machine_MemberCount'
GO

CREATE PROCEDURE [dbo].pts_Machine_MemberCount
   @MemberID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

SELECT @Result = COUNT(*) FROM Machine WHERE MemberID = @MemberID

GO