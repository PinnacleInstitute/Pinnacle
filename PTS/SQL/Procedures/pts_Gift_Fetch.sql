EXEC [dbo].pts_CheckProc 'pts_Gift_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Gift_Fetch ( 
   @GiftID int,
   @MemberID int OUTPUT,
   @PaymentID int OUTPUT,
   @Member2ID int OUTPUT,
   @MemberName nvarchar (60) OUTPUT,
   @MemberName2 nvarchar (60) OUTPUT,
   @GiftDate datetime OUTPUT,
   @ActiveDate datetime OUTPUT,
   @Amount money OUTPUT,
   @Purpose nvarchar (10) OUTPUT,
   @Notes varchar (100) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = gc.MemberID ,
   @PaymentID = gc.PaymentID ,
   @Member2ID = gc.Member2ID ,
   @MemberName = me.CompanyName ,
   @MemberName2 = me2.CompanyName ,
   @GiftDate = gc.GiftDate ,
   @ActiveDate = gc.ActiveDate ,
   @Amount = gc.Amount ,
   @Purpose = gc.Purpose ,
   @Notes = gc.Notes
FROM Gift AS gc (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (gc.MemberID = me.MemberID)
LEFT OUTER JOIN Member AS me2 (NOLOCK) ON (gc.Member2ID = me2.MemberID)
WHERE gc.GiftID = @GiftID

GO