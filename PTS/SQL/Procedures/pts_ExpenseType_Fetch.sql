EXEC [dbo].pts_CheckProc 'pts_ExpenseType_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_ExpenseType_Fetch ( 
   @ExpenseTypeID int,
   @ExpType int OUTPUT,
   @ExpenseTypeName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @TaxType int OUTPUT,
   @IsRequired bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ExpType = ext.ExpType ,
   @ExpenseTypeName = ext.ExpenseTypeName ,
   @Seq = ext.Seq ,
   @TaxType = ext.TaxType ,
   @IsRequired = ext.IsRequired
FROM ExpenseType AS ext (NOLOCK)
WHERE ext.ExpenseTypeID = @ExpenseTypeID

GO