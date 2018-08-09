EXEC [dbo].pts_CheckProc 'pts_BarterCredit_Update'
 GO

CREATE PROCEDURE [dbo].pts_BarterCredit_Update ( 
   @BarterCreditID int,
   @OwnerType int,
   @OwnerID int,
   @BarterAdID int,
   @CreditDate datetime,
   @Amount money,
   @Status int,
   @CreditType int,
   @StartDate datetime,
   @EndDate datetime,
   @Reference varchar (30),
   @Notes varchar (500),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE bac
SET bac.OwnerType = @OwnerType ,
   bac.OwnerID = @OwnerID ,
   bac.BarterAdID = @BarterAdID ,
   bac.CreditDate = @CreditDate ,
   bac.Amount = @Amount ,
   bac.Status = @Status ,
   bac.CreditType = @CreditType ,
   bac.StartDate = @StartDate ,
   bac.EndDate = @EndDate ,
   bac.Reference = @Reference ,
   bac.Notes = @Notes
FROM BarterCredit AS bac
WHERE bac.BarterCreditID = @BarterCreditID

GO