EXEC [dbo].pts_CheckProc 'pts_AuthUser_ChangePassword'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_ChangePassword
   @AuthUserID int ,
   @Password nvarchar (30) OUTPUT ,
   @NewPassword nvarchar (30) OUTPUT ,
   @ConfirmPassword nvarchar (30) OUTPUT ,
   @UserID int
AS

DECLARE @mNow datetime, 
         @mEmail nvarchar (80), 
         @mIsValid bit

SET NOCOUNT ON

IF ((@ConfirmPassword <> @NewPassword))
   BEGIN
   RAISERROR ('-2147220508: Oops, New Password and Confirm Password do not match. Please re-enter the Confirm Password to continue.', 16, 1)
   RETURN @@ERROR
   END

IF ((@Password = @NewPassword))
   BEGIN
   RAISERROR ('-2147220509: Oops, New Password and Password match. Please re-enter a New Password to continue.', 16, 1)
   RETURN @@ERROR
   END

SET @mNow = GETDATE()
EXEC pts_AuthUser_CheckPassword
   @AuthUserID ,
   @Password ,
   @mIsValid OUTPUT

IF ((@mIsValid = 1))
   BEGIN
   UPDATE au
   SET au.Password = @NewPassword , 
      au.ChangeDate = @mNow , 
      au.ChangeID = @UserID 
   FROM AuthUser AS au
   WHERE    (au.AuthUserID = @AuthUserID)


   END

IF ((@mIsValid <> 1))
   BEGIN
   RAISERROR ('-2147220510: Oops, Change password failed. The old password is not correct.', 16, 1)
   RETURN @@ERROR
   END

SET @Password = ''
SET @NewPassword = ''
SET @ConfirmPassword = ''
GO