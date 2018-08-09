EXEC [dbo].pts_CheckProc 'pts_Broadcast_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Broadcast_Delete ( 
   @BroadcastID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bc
FROM Broadcast AS bc
WHERE bc.BroadcastID = @BroadcastID

GO