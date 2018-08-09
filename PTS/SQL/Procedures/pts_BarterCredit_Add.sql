EXEC [dbo].pts_CheckProc 'pts_BarterCredit_Add'
 GO

CREATE PROCEDURE [dbo].pts_BarterCredit_Add ( 
   @BarterCreditID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO BarterCredit (
            OwnerType , 
            OwnerID , 
            BarterAdID , 
            CreditDate , 
            Amount , 
            Status , 
            CreditType , 
            StartDate , 
            EndDate , 
            Reference , 
            Notes
            )
VALUES (
            @OwnerType ,
            @OwnerID ,
            @BarterAdID ,
            @CreditDate ,
            @Amount ,
            @Status ,
            @CreditType ,
            @StartDate ,
            @EndDate ,
            @Reference ,
            @Notes            )

SET @mNewID = @@IDENTITY

SET @BarterCreditID = @mNewID

GO