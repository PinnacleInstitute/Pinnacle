EXEC [dbo].pts_CheckProc 'pts_Payout_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Payout_Fetch ( 
   @PayoutID int,
   @CompanyID int OUTPUT,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @PayDate datetime OUTPUT,
   @PaidDate datetime OUTPUT,
   @Amount money OUTPUT,
   @Status int OUTPUT,
   @Notes varchar (500) OUTPUT,
   @PayType int OUTPUT,
   @Reference varchar (30) OUTPUT,
   @Show int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = po.CompanyID ,
   @OwnerType = po.OwnerType ,
   @OwnerID = po.OwnerID ,
   @PayDate = po.PayDate ,
   @PaidDate = po.PaidDate ,
   @Amount = po.Amount ,
   @Status = po.Status ,
   @Notes = po.Notes ,
   @PayType = po.PayType ,
   @Reference = po.Reference ,
   @Show = po.Show
FROM Payout AS po (NOLOCK)
WHERE po.PayoutID = @PayoutID

GO