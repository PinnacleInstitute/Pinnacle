EXEC [dbo].pts_CheckProc 'pts_Audit_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Audit_Delete ( 
   @AuditID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE adt
FROM Audit AS adt
WHERE adt.AuditID = @AuditID

GO