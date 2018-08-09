EXEC [dbo].pts_CheckProc 'pts_Broadcast_ListEmail'
GO

--EXEC pts_Broadcast_ListEmail 0
--EXEC pts_Broadcast_ListEmail 1

CREATE PROCEDURE [dbo].pts_Broadcast_ListEmail
   @BroadcastID int
AS

SET NOCOUNT ON
DECLARE @BID int, @MemberID int, @FriendGroupID int, @Stories int 

DECLARE @Broadcast TABLE(
   BroadcastID int ,
   MemberID int ,
   FriendGroupID int ,
   Stories int 
)

DECLARE Broadcast_cursor CURSOR LOCAL STATIC FOR 
SELECT TOP 3 BroadcastID, MemberID, FriendGroupID, Stories FROM Broadcast 
WHERE Status = 2 AND (@BroadcastID = 0 OR BroadcastID = @BroadcastID)
ORDER BY ActiveDate DESC

OPEN Broadcast_cursor
FETCH NEXT FROM Broadcast_cursor INTO @BID, @MemberID, @FriendGroupID, @Stories
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Broadcast SET Status = 3 WHERE BroadcastID = @BID
	INSERT INTO @Broadcast (BroadcastID, MemberID, FriendGroupID, Stories ) VALUES ( @BID, @MemberID, @FriendGroupID, @Stories )
	FETCH NEXT FROM Broadcast_cursor INTO @BID, @MemberID, @FriendGroupID, @Stories
END
CLOSE Broadcast_cursor
DEALLOCATE Broadcast_cursor

SELECT BroadcastID, MemberID, FriendGroupID, Stories FROM @Broadcast

GO