EXEC [dbo].pts_CheckProc 'pts_AuthUser_UpdateUserKey'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_UpdateUserKey
   @AuthUserID int ,
   @UserKey nvarchar (40) ,
   @UserID int
AS

SET NOCOUNT ON

UPDATE au
SET au.UserKey = @UserKey 
FROM AuthUser AS au
WHERE (au.AuthUserID = @AuthUserID)


GO