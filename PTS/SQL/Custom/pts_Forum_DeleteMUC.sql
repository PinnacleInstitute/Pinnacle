EXEC [dbo].pts_CheckProc 'pts_Forum_DeleteMUC'
GO

CREATE PROCEDURE [dbo].pts_Forum_DeleteMUC
   @ForumID int

AS

SET         NOCOUNT ON

DELETE FROM mucRoom 
WHERE ForumID = @ForumID

GO