EXEC [dbo].pts_CheckProc 'pts_Friend_UpdateStatus'
GO

CREATE PROCEDURE [dbo].pts_Friend_UpdateStatus
   @Result int OUTPUT ,
   @FriendID int ,
   @Status int
AS

SET NOCOUNT ON

UPDATE Friend SET Status = @Status WHERE FriendID = @FriendID

GO