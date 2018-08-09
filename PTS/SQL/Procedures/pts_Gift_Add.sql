EXEC [dbo].pts_CheckProc 'pts_Gift_Add'
 GO

CREATE PROCEDURE [dbo].pts_Gift_Add ( 
   @GiftID int OUTPUT,
   @MemberID int,
   @PaymentID int,
   @Member2ID int,
   @GiftDate datetime,
   @ActiveDate datetime,
   @Amount money,
   @Purpose nvarchar (10),
   @Notes varchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Gift (
            MemberID , 
            PaymentID , 
            Member2ID , 
            GiftDate , 
            ActiveDate , 
            Amount , 
            Purpose , 
            Notes
            )
VALUES (
            @MemberID ,
            @PaymentID ,
            @Member2ID ,
            @GiftDate ,
            @ActiveDate ,
            @Amount ,
            @Purpose ,
            @Notes            )

SET @mNewID = @@IDENTITY

SET @GiftID = @mNewID

GO