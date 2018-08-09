EXEC [dbo].pts_CheckProc 'pts_AuthUser_UpdateUserType'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_UpdateUserType
   @AuthUserID int ,
   @UserType int ,
   @UserID int
AS

SET NOCOUNT ON

UPDATE au
SET au.UserType = @UserType 
FROM AuthUser AS au
WHERE (au.AuthUserID = @AuthUserID)


GO