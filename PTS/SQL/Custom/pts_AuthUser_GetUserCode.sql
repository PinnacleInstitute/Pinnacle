EXEC [dbo].pts_CheckProc 'pts_AuthUser_GetUserCode'
GO
--declare @UserCode nvarchar (10) exec pts_AuthUser_GetUserCode 1, @UserCode OUTPUT print @UserCode

CREATE PROCEDURE [dbo].pts_AuthUser_GetUserCode
   @AuthUserID int ,
   @UserCode nvarchar (10) OUTPUT
AS

SET NOCOUNT ON

IF @AuthUserID < 0
BEGIN
	SET @AuthUserID = ABS(@AuthUserID)
	EXEC pts_AuthUser_SetUserCode @AuthUserID, @UserCode OUTPUT
END
ELSE
BEGIN
	SELECT @UserCode = UserCode FROM AuthUser WHERE AuthUserID = @AuthUserID
END

GO