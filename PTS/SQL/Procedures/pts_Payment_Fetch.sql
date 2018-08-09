EXEC [dbo].pts_CheckProc 'pts_Payment_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Payment_Fetch ( 
   @PaymentID int,
   @CompanyID int OUTPUT,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @BillingID int OUTPUT,
   @ProductID int OUTPUT,
   @PaidID int OUTPUT,
   @PayDate datetime OUTPUT,
   @PaidDate datetime OUTPUT,
   @PayType int OUTPUT,
   @Amount money OUTPUT,
   @Total money OUTPUT,
   @Credit money OUTPUT,
   @Retail money OUTPUT,
   @Commission money OUTPUT,
   @Description varchar (200) OUTPUT,
   @Purpose nvarchar (100) OUTPUT,
   @Status int OUTPUT,
   @Reference varchar (40) OUTPUT,
   @Notes varchar (500) OUTPUT,
   @CommStatus int OUTPUT,
   @CommDate datetime OUTPUT,
   @TokenType int OUTPUT,
   @TokenOwner int OUTPUT,
   @Token int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = pa.CompanyID ,
   @OwnerType = pa.OwnerType ,
   @OwnerID = pa.OwnerID ,
   @BillingID = pa.BillingID ,
   @ProductID = pa.ProductID ,
   @PaidID = pa.PaidID ,
   @PayDate = pa.PayDate ,
   @PaidDate = pa.PaidDate ,
   @PayType = pa.PayType ,
   @Amount = pa.Amount ,
   @Total = pa.Total ,
   @Credit = pa.Credit ,
   @Retail = pa.Retail ,
   @Commission = pa.Commission ,
   @Description = pa.Description ,
   @Purpose = pa.Purpose ,
   @Status = pa.Status ,
   @Reference = pa.Reference ,
   @Notes = pa.Notes ,
   @CommStatus = pa.CommStatus ,
   @CommDate = pa.CommDate ,
   @TokenType = pa.TokenType ,
   @TokenOwner = pa.TokenOwner ,
   @Token = pa.Token
FROM Payment AS pa (NOLOCK)
WHERE pa.PaymentID = @PaymentID

GO