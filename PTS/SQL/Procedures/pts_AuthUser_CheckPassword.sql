EXEC [dbo].pts_CheckProc 'pts_AuthUser_CheckPassword'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_CheckPassword
   @AuthUserID int ,
   @Password nvarchar (30) ,
   @IsValid bit OUTPUT
AS

DECLARE @mPassword nvarchar (30), 
         @mIsValid bit

SET NOCOUNT ON

SELECT      @mPassword = ISNULL(au.Password, '')
FROM AuthUser AS au (NOLOCK)
WHERE (au.AuthUserID = @AuthUserID)


IF ((@mPassword = @Password))
   BEGIN
   SET @IsValid = 1
   END

IF ((@mPassword <> @Password))
   BEGIN
   SET @IsValid = 0
   END

GO