EXEC [dbo].pts_CheckProc 'pts_BoardUser_Delete'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_Delete
   @BoardUserID int ,
   @UserID int
AS

SET NOCOUNT ON

DELETE mbu
FROM BoardUser AS mbu
WHERE (mbu.BoardUserID = @BoardUserID)


GO