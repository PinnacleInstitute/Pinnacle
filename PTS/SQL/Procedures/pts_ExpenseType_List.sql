EXEC [dbo].pts_CheckProc 'pts_ExpenseType_List'
GO

CREATE PROCEDURE [dbo].pts_ExpenseType_List
   @UserID int
AS

SET NOCOUNT ON

SELECT      ext.ExpenseTypeID, 
         ext.ExpType, 
         ext.ExpenseTypeName, 
         ext.TaxType, 
         ext.IsRequired, 
         ext.Seq
FROM ExpenseType AS ext (NOLOCK)
ORDER BY   ext.ExpType , ext.Seq

GO