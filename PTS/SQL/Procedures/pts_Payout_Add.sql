EXEC [dbo].pts_CheckProc 'pts_Payout_Add'
 GO

CREATE PROCEDURE [dbo].pts_Payout_Add ( 
   @PayoutID int OUTPUT,
   @CompanyID int,
   @OwnerType int,
   @OwnerID int,
   @PayDate datetime,
   @PaidDate datetime,
   @Amount money,
   @Status int,
   @Notes varchar (500),
   @PayType int,
   @Reference varchar (30),
   @Show int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Payout (
            CompanyID , 
            OwnerType , 
            OwnerID , 
            PayDate , 
            PaidDate , 
            Amount , 
            Status , 
            Notes , 
            PayType , 
            Reference , 
            Show
            )
VALUES (
            @CompanyID ,
            @OwnerType ,
            @OwnerID ,
            @PayDate ,
            @PaidDate ,
            @Amount ,
            @Status ,
            @Notes ,
            @PayType ,
            @Reference ,
            @Show            )

SET @mNewID = @@IDENTITY

SET @PayoutID = @mNewID

GO