EXEC [dbo].pts_CheckProc 'pts_Cash_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Cash_Fetch ( 
   @CashID int,
   @MemberID int OUTPUT,
   @RefID int OUTPUT,
   @CashDate datetime OUTPUT,
   @CashType int OUTPUT,
   @Amount money OUTPUT,
   @Note varchar (100) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = cas.MemberID ,
   @RefID = cas.RefID ,
   @CashDate = cas.CashDate ,
   @CashType = cas.CashType ,
   @Amount = cas.Amount ,
   @Note = cas.Note
FROM Cash AS cas (NOLOCK)
WHERE cas.CashID = @CashID

GO