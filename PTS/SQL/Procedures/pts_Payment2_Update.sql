EXEC [dbo].pts_CheckProc 'pts_Payment2_Update'
 GO

CREATE PROCEDURE [dbo].pts_Payment2_Update ( 
   @Payment2ID int,
   @MerchantID int,
   @ConsumerID int,
   @StaffID int,
   @AwardID int,
   @SalesOrderID int,
   @StatementID int,
   @PayDate datetime,
   @PayType int,
   @Status int,
   @Total money,
   @Amount money,
   @Merchant money,
   @Cashback money,
   @Fee money,
   @PayCoins bigint,
   @PayRate money,
   @PaidCoins bigint,
   @Reference varchar (40),
   @Description nvarchar (100),
   @Notes varchar (500),
   @Ticket int,
   @CommStatus int,
   @CommDate datetime,
   @CoinStatus int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pa2
SET pa2.MerchantID = @MerchantID ,
   pa2.ConsumerID = @ConsumerID ,
   pa2.StaffID = @StaffID ,
   pa2.AwardID = @AwardID ,
   pa2.SalesOrderID = @SalesOrderID ,
   pa2.StatementID = @StatementID ,
   pa2.PayDate = @PayDate ,
   pa2.PayType = @PayType ,
   pa2.Status = @Status ,
   pa2.Total = @Total ,
   pa2.Amount = @Amount ,
   pa2.Merchant = @Merchant ,
   pa2.Cashback = @Cashback ,
   pa2.Fee = @Fee ,
   pa2.PayCoins = @PayCoins ,
   pa2.PayRate = @PayRate ,
   pa2.PaidCoins = @PaidCoins ,
   pa2.Reference = @Reference ,
   pa2.Description = @Description ,
   pa2.Notes = @Notes ,
   pa2.Ticket = @Ticket ,
   pa2.CommStatus = @CommStatus ,
   pa2.CommDate = @CommDate ,
   pa2.CoinStatus = @CoinStatus
FROM Payment2 AS pa2
WHERE pa2.Payment2ID = @Payment2ID

GO