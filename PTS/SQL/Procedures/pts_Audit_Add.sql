EXEC [dbo].pts_CheckProc 'pts_Audit_Add'
 GO

CREATE PROCEDURE [dbo].pts_Audit_Add ( 
   @AuditID int OUTPUT,
   @AuthUserID int,
   @AuditDate datetime,
   @Action int,
   @Page varchar (100),
   @IP varchar (16),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Audit (
            AuthUserID , 
            AuditDate , 
            Action , 
            Page , 
            IP
            )
VALUES (
            @AuthUserID ,
            @AuditDate ,
            @Action ,
            @Page ,
            @IP            )

SET @mNewID = @@IDENTITY

SET @AuditID = @mNewID

GO