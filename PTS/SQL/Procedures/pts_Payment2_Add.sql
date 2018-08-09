EXEC [dbo].pts_CheckProc 'pts_Payment2_Add'
 GO

CREATE PROCEDURE [dbo].pts_Payment2_Add ( 
   @Payment2ID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Payment2 (
            MerchantID , 
            ConsumerID , 
            StaffID , 
            AwardID , 
            SalesOrderID , 
            StatementID , 
            PayDate , 
            PayType , 
            Status , 
            Total , 
            Amount , 
            Merchant , 
            Cashback , 
            Fee , 
            PayCoins , 
            PayRate , 
            PaidCoins , 
            Reference , 
            Description , 
            Notes , 
            Ticket , 
            CommStatus , 
            CommDate , 
            CoinStatus
            )
VALUES (
            @MerchantID ,
            @ConsumerID ,
            @StaffID ,
            @AwardID ,
            @SalesOrderID ,
            @StatementID ,
            @PayDate ,
            @PayType ,
            @Status ,
            @Total ,
            @Amount ,
            @Merchant ,
            @Cashback ,
            @Fee ,
            @PayCoins ,
            @PayRate ,
            @PaidCoins ,
            @Reference ,
            @Description ,
            @Notes ,
            @Ticket ,
            @CommStatus ,
            @CommDate ,
            @CoinStatus            )

SET @mNewID = @@IDENTITY

SET @Payment2ID = @mNewID

GO