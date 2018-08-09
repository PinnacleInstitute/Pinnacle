EXEC [dbo].pts_CheckProc 'pts_AuthUser_CheckLogon'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_CheckLogon
   @AuthUserID int ,
   @Logon nvarchar (80) ,
   @IsValid bit OUTPUT
AS

DECLARE @mAuthUserID int, 
         @mIsValid bit

SET NOCOUNT ON

SELECT      @mAuthUserID = ISNULL(au.AuthUserID, 0)
FROM AuthUser AS au (NOLOCK)
WHERE (au.Logon = @Logon)


IF ((@mAuthUserID = @AuthUserID))
   BEGIN
   SET @IsValid = 1
   END

IF ((@mAuthUserID <> @AuthUserID))
   BEGIN
   SET @IsValid = 0
   END

GO