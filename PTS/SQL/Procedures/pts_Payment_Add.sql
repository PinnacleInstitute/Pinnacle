EXEC [dbo].pts_CheckProc 'pts_Payment_Add'
 GO

CREATE PROCEDURE [dbo].pts_Payment_Add ( 
   @PaymentID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Payment (
            CompanyID , 
            OwnerType , 
            OwnerID , 
            BillingID , 
            ProductID , 
            PaidID , 
            PayDate , 
            PaidDate , 
            PayType , 
            Amount , 
            Total , 
            Credit , 
            Retail , 
            Commission , 
            Description , 
            Purpose , 
            Status , 
            Reference , 
            Notes , 
            CommStatus , 
            CommDate , 
            TokenType , 
            TokenOwner , 
            Token
            )
VALUES (
            @CompanyID ,
            @OwnerType ,
            @OwnerID ,
            @BillingID ,
            @ProductID ,
            @PaidID ,
            @PayDate ,
            @PaidDate ,
            @PayType ,
            @Amount ,
            @Total ,
            @Credit ,
            @Retail ,
            @Commission ,
            @Description ,
            @Purpose ,
            @Status ,
            @Reference ,
            @Notes ,
            @CommStatus ,
            @CommDate ,
            @TokenType ,
            @TokenOwner ,
            @Token            )

SET @mNewID = @@IDENTITY

SET @PaymentID = @mNewID

GO