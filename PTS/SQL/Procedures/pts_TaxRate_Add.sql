EXEC [dbo].pts_CheckProc 'pts_TaxRate_Add'
 GO

CREATE PROCEDURE [dbo].pts_TaxRate_Add ( 
   @TaxRateID int OUTPUT,
   @Year int,
   @TaxType int,
   @Rate money,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO TaxRate (
            Year , 
            TaxType , 
            Rate
            )
VALUES (
            @Year ,
            @TaxType ,
            @Rate            )

SET @mNewID = @@IDENTITY

SET @TaxRateID = @mNewID

GO