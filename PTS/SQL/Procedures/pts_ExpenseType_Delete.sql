EXEC [dbo].pts_CheckProc 'pts_ExpenseType_Delete'
 GO

CREATE PROCEDURE [dbo].pts_ExpenseType_Delete ( 
   @ExpenseTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ext
FROM ExpenseType AS ext
WHERE ext.ExpenseTypeID = @ExpenseTypeID

GO