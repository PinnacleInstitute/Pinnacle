EXEC [dbo].pts_CheckProc 'pts_FriendGroup_Count'
GO

CREATE PROCEDURE [dbo].pts_FriendGroup_Count
   @Result int OUTPUT ,
   @MemberID int
AS

SET NOCOUNT ON

SELECT @Result = COUNT(*) FROM FriendGroup WHERE MemberID = @MemberID

GO