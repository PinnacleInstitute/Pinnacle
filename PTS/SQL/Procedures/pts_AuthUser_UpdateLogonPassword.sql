EXEC [dbo].pts_CheckProc 'pts_AuthUser_UpdateLogonPassword'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_UpdateLogonPassword
   @AuthUserID int ,
   @Logon nvarchar (80) ,
   @Password nvarchar (30) ,
   @UserID int
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()
UPDATE au
SET au.Logon = @Logon , 
   au.Password = @Password , 
   au.ChangeDate = @mNow , 
   au.ChangeID = @UserID 
FROM AuthUser AS au
WHERE (au.AuthUserID = @AuthUserID)


GO