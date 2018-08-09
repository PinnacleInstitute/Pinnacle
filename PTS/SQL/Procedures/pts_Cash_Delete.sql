EXEC [dbo].pts_CheckProc 'pts_Cash_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Cash_Delete ( 
   @CashID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE cas
FROM Cash AS cas
WHERE cas.CashID = @CashID

GO