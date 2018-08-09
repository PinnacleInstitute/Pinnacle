EXEC [dbo].pts_CheckProc 'pts_AuthUser_IsLogon'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_IsLogon
   @Logon nvarchar (80) ,
   @IsAvailable bit OUTPUT
AS

DECLARE @mAuthUserID int, 
         @mIsAvailable bit

SET NOCOUNT ON

SELECT      @mAuthUserID = ISNULL(au.AuthUserID, 0)
FROM AuthUser AS au (NOLOCK)
WHERE (au.Logon = @Logon)


IF ((@mAuthUserID IS NULL))
   BEGIN
   SET @IsAvailable = 1
   END

IF ((@mAuthUserID <> 0))
   BEGIN
   SET @IsAvailable = 0
   END

GO