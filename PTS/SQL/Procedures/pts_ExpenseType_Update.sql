EXEC [dbo].pts_CheckProc 'pts_ExpenseType_Update'
 GO

CREATE PROCEDURE [dbo].pts_ExpenseType_Update ( 
   @ExpenseTypeID int,
   @ExpType int,
   @ExpenseTypeName nvarchar (40),
   @Seq int,
   @TaxType int,
   @IsRequired bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ext
SET ext.ExpType = @ExpType ,
   ext.ExpenseTypeName = @ExpenseTypeName ,
   ext.Seq = @Seq ,
   ext.TaxType = @TaxType ,
   ext.IsRequired = @IsRequired
FROM ExpenseType AS ext
WHERE ext.ExpenseTypeID = @ExpenseTypeID

GO