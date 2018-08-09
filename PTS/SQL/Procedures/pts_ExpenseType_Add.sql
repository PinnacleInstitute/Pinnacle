EXEC [dbo].pts_CheckProc 'pts_ExpenseType_Add'
 GO

CREATE PROCEDURE [dbo].pts_ExpenseType_Add ( 
   @ExpenseTypeID int OUTPUT,
   @ExpType int,
   @ExpenseTypeName nvarchar (40),
   @Seq int,
   @TaxType int,
   @IsRequired bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO ExpenseType (
            ExpType , 
            ExpenseTypeName , 
            Seq , 
            TaxType , 
            IsRequired
            )
VALUES (
            @ExpType ,
            @ExpenseTypeName ,
            @Seq ,
            @TaxType ,
            @IsRequired            )

SET @mNewID = @@IDENTITY

SET @ExpenseTypeID = @mNewID

GO