EXEC [dbo].pts_CheckProc 'pts_AuthUser_SetUserCode'
GO

--declare @UserCode nvarchar (10) exec pts_AuthUser_SetUserCode 1, @UserCode OUTPUT print @UserCode

CREATE PROCEDURE [dbo].pts_AuthUser_SetUserCode
   @AuthUserID int ,
   @UserCode nvarchar (10) OUTPUT
AS

SET NOCOUNT ON

EXEC pts_System_GetPassword @UserCode OUTPUT

UPDATE AuthUser SET UserCode = @UserCode WHERE AuthUserID = @AuthUserID

GO

