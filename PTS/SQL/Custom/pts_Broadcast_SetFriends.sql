EXEC [dbo].pts_CheckProc 'pts_Broadcast_SetFriends'
GO

CREATE PROCEDURE [dbo].pts_Broadcast_SetFriends
   @BroadcastID int ,
   @Friends int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
UPDATE Broadcast SET Friends = @Friends WHERE BroadcastID = @BroadcastID
SET @Result = @Friends

GO