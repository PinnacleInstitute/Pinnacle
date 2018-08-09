EXEC [dbo].pts_CheckProc 'pts_AuthUser_ResetLogon'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_ResetLogon
   @AuthUserID int ,
   @Email nvarchar (80) ,
   @Logon nvarchar (80) OUTPUT ,
   @UserID int
AS

DECLARE @mLogon nvarchar (80), 
         @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()
EXEC pts_System_GetLogon
   @mLogon OUTPUT ,
   @Email

UPDATE au
SET au.Logon = @mLogon , 
   au.ChangeDate = @mNow , 
   au.ChangeID = @UserID 
FROM AuthUser AS au
WHERE (au.AuthUserID = @AuthUserID)


SET @Logon = @mLogon
GO