EXEC [dbo].pts_CheckProc 'pts_ExpenseType_EnumUserExpenseType'
GO

CREATE PROCEDURE [dbo].pts_ExpenseType_EnumUserExpenseType
   @ExpType int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      ext.ExpenseTypeID AS 'ID', 
         ext.ExpenseTypeName AS 'Name'
FROM ExpenseType AS ext (NOLOCK)
WHERE (ext.ExpType = @ExpType)

ORDER BY   ext.Seq

GO