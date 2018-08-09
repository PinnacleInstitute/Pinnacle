EXEC [dbo].pts_CheckProc 'pts_AuthUser_ChangeLogon'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_ChangeLogon
   @AuthUserID int ,
   @Logon nvarchar (80) OUTPUT ,
   @NewLogon nvarchar (80) OUTPUT ,
   @ConfirmLogon nvarchar (80) OUTPUT ,
   @UserID int
AS

DECLARE @mNow datetime, 
         @mEmail nvarchar (80), 
         @mIsValid bit

SET NOCOUNT ON

IF ((@NewLogon <> @ConfirmLogon))
   BEGIN
   RAISERROR ('-2147220506: Oops, New Logon and Confirm Logon do not match. Please re-enter the Confirm Logon to continue.', 16, 1)
   RETURN @@ERROR
   END

SET @mNow = GETDATE()
EXEC pts_AuthUser_CheckLogon
   @AuthUserID ,
   @Logon ,
   @mIsValid OUTPUT

IF ((@mIsValid = 1))
   BEGIN
   UPDATE au
   SET au.Logon = @NewLogon , 
      au.ChangeDate = @mNow , 
      au.ChangeID = @UserID 
   FROM AuthUser AS au
   WHERE    (au.AuthUserID = @AuthUserID)


   END

IF ((@mIsValid <> 1))
   BEGIN
   RAISERROR ('-2147220507: Oops, Change logon failed. The old logon is not correct.', 16, 1)
   RETURN @@ERROR
   END

SET @Logon = @NewLogon
SET @NewLogon = ''
SET @ConfirmLogon = ''
GO