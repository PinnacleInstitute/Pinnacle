EXEC [dbo].pts_CheckProc 'pts_Prepaid_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Prepaid_Fetch ( 
   @PrepaidID int,
   @MemberID int OUTPUT,
   @RefID int OUTPUT,
   @PayDate datetime OUTPUT,
   @PayType int OUTPUT,
   @Amount money OUTPUT,
   @Note varchar (100) OUTPUT,
   @BV money OUTPUT,
   @Bonus int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = pre.MemberID ,
   @RefID = pre.RefID ,
   @PayDate = pre.PayDate ,
   @PayType = pre.PayType ,
   @Amount = pre.Amount ,
   @Note = pre.Note ,
   @BV = pre.BV ,
   @Bonus = pre.Bonus
FROM Prepaid AS pre (NOLOCK)
WHERE pre.PrepaidID = @PrepaidID

GO