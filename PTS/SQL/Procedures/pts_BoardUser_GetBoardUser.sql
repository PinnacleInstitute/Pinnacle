EXEC [dbo].pts_CheckProc 'pts_BoardUser_GetBoardUser'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_GetBoardUser
   @UserID int ,
   @BoardUserID int OUTPUT
AS

SET NOCOUNT ON

SELECT      @BoardUserID = ISNULL(mbu.BoardUserID, 0)
FROM BoardUser AS mbu (NOLOCK)
WHERE (mbu.AuthUserID = @UserID)


GO