EXEC [dbo].pts_CheckProc 'pts_Gift_Update'
 GO

CREATE PROCEDURE [dbo].pts_Gift_Update ( 
   @GiftID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE gc
SET gc.MemberID = @MemberID ,
   gc.PaymentID = @PaymentID ,
   gc.Member2ID = @Member2ID ,
   gc.GiftDate = @GiftDate ,
   gc.ActiveDate = @ActiveDate ,
   gc.Amount = @Amount ,
   gc.Purpose = @Purpose ,
   gc.Notes = @Notes
FROM Gift AS gc
WHERE gc.GiftID = @GiftID

GO