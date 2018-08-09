EXEC [dbo].pts_CheckProc 'pts_Message_UpdateThread'
 GO


CREATE PROCEDURE [dbo].pts_Message_UpdateThread
   @ThreadID int ,
   @BoardUserID int ,
   @UserID int
AS

SET         NOCOUNT ON

DECLARE @Count int

SELECT      @Count = (COUNT(MessageID) - 1)
FROM Message 
WHERE (ThreadID = @ThreadID)

UPDATE Message 
SET Replies = @Count, ChangeDate = CURRENT_TIMESTAMP, ModifyID = @BoardUserID
WHERE (ThreadID = @ThreadID) AND (ParentID = 0)

GO