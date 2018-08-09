EXEC [dbo].pts_CheckProc 'pts_BarterCredit_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_BarterCredit_Fetch ( 
   @BarterCreditID int,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @BarterAdID int OUTPUT,
   @CreditDate datetime OUTPUT,
   @Amount money OUTPUT,
   @Status int OUTPUT,
   @CreditType int OUTPUT,
   @StartDate datetime OUTPUT,
   @EndDate datetime OUTPUT,
   @Reference varchar (30) OUTPUT,
   @Notes varchar (500) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @OwnerType = bac.OwnerType ,
   @OwnerID = bac.OwnerID ,
   @BarterAdID = bac.BarterAdID ,
   @CreditDate = bac.CreditDate ,
   @Amount = bac.Amount ,
   @Status = bac.Status ,
   @CreditType = bac.CreditType ,
   @StartDate = bac.StartDate ,
   @EndDate = bac.EndDate ,
   @Reference = bac.Reference ,
   @Notes = bac.Notes
FROM BarterCredit AS bac (NOLOCK)
WHERE bac.BarterCreditID = @BarterCreditID

GO