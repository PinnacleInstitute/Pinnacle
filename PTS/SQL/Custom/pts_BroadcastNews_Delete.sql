EXEC [dbo].pts_CheckProc 'pts_BroadcastNews_Delete'
 GO

CREATE PROCEDURE [dbo].pts_BroadcastNews_Delete ( 
   @BroadcastNewsID int,
   @UserID int
      )
AS

SET NOCOUNT ON

DECLARE @BroadcastID int
SELECT @BroadcastID = BroadcastID FROM BroadcastNews WHERE BroadcastNewsID = @BroadcastNewsID

DELETE bcn
FROM BroadcastNews AS bcn
WHERE bcn.BroadcastNewsID = @BroadcastNewsID

UPDATE Broadcast SET Stories = Stories - 1 WHERE BroadcastID = @BroadcastID

GO