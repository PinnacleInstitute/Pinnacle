EXEC [dbo].pts_CheckProc 'pts_AuthUser_ResetPassword'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_ResetPassword
   @AuthUserID int ,
   @UserID int
AS

DECLARE @mPassword nvarchar (30), 
         @mIsValid bit, 
         @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()
EXEC pts_System_GetPassword
   @mPassword OUTPUT

UPDATE au
SET au.Password = @mPassword , 
   au.ChangeDate = @mNow , 
   au.ChangeID = @UserID 
FROM AuthUser AS au
WHERE (au.AuthUserID = @AuthUserID)


IF ((@mIsValid <> 1))
   BEGIN
   RAISERROR ('-2147220511: Oops, Reset password failed. Can not locate user.', 16, 1)
   RETURN @@ERROR
   END

GO