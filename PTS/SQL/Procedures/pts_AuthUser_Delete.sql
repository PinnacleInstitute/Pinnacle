EXEC [dbo].pts_CheckProc 'pts_AuthUser_Delete'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_Delete
   @AuthUserID int ,
   @UserID int
AS

SET NOCOUNT ON

DELETE au
FROM AuthUser AS au
WHERE (au.AuthUserID = @AuthUserID)


GO