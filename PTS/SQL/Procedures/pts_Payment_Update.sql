EXEC [dbo].pts_CheckProc 'pts_Payment_Update'
 GO

CREATE PROCEDURE [dbo].pts_Payment_Update ( 
   @PaymentID int,
   @CompanyID int,
   @OwnerType int,
   @OwnerID int,
   @BillingID int,
   @ProductID int,
   @PaidID int,
   @PayDate datetime,
   @PaidDate datetime,
   @PayType int,
   @Amount money,
   @Total money,
   @Credit money,
   @Retail money,
   @Commission money,
   @Description varchar (200),
   @Purpose nvarchar (100),
   @Status int,
   @Reference varchar (40),
   @Notes varchar (500),
   @CommStatus int,
   @CommDate datetime,
   @TokenType int,
   @TokenOwner int,
   @Token int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pa
SET pa.CompanyID = @CompanyID ,
   pa.OwnerType = @OwnerType ,
   pa.OwnerID = @OwnerID ,
   pa.BillingID = @BillingID ,
   pa.ProductID = @ProductID ,
   pa.PaidID = @PaidID ,
   pa.PayDate = @PayDate ,
   pa.PaidDate = @PaidDate ,
   pa.PayType = @PayType ,
   pa.Amount = @Amount ,
   pa.Total = @Total ,
   pa.Credit = @Credit ,
   pa.Retail = @Retail ,
   pa.Commission = @Commission ,
   pa.Description = @Description ,
   pa.Purpose = @Purpose ,
   pa.Status = @Status ,
   pa.Reference = @Reference ,
   pa.Notes = @Notes ,
   pa.CommStatus = @CommStatus ,
   pa.CommDate = @CommDate ,
   pa.TokenType = @TokenType ,
   pa.TokenOwner = @TokenOwner ,
   pa.Token = @Token
FROM Payment AS pa
WHERE pa.PaymentID = @PaymentID

GO