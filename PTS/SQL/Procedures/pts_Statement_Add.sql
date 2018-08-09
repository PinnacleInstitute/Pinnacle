EXEC [dbo].pts_CheckProc 'pts_Statement_Add'
 GO

CREATE PROCEDURE [dbo].pts_Statement_Add ( 
   @StatementID int OUTPUT,
   @CompanyID int,
   @MerchantID int,
   @StatementDate datetime,
   @PaidDate datetime,
   @Amount money,
   @Status int,
   @PayType int,
   @Reference varchar (30),
   @Notes varchar (500),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Statement (
            CompanyID , 
            MerchantID , 
            StatementDate , 
            PaidDate , 
            Amount , 
            Status , 
            PayType , 
            Reference , 
            Notes
            )
VALUES (
            @CompanyID ,
            @MerchantID ,
            @StatementDate ,
            @PaidDate ,
            @Amount ,
            @Status ,
            @PayType ,
            @Reference ,
            @Notes            )

SET @mNewID = @@IDENTITY

SET @StatementID = @mNewID

GO