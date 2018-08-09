EXEC [dbo].pts_CheckProc 'pts_Prepaid_Update'
 GO

CREATE PROCEDURE [dbo].pts_Prepaid_Update ( 
   @PrepaidID int,
   @MemberID int,
   @RefID int,
   @PayDate datetime,
   @PayType int,
   @Amount money,
   @Note varchar (100),
   @BV money,
   @Bonus int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pre
SET pre.MemberID = @MemberID ,
   pre.RefID = @RefID ,
   pre.PayDate = @PayDate ,
   pre.PayType = @PayType ,
   pre.Amount = @Amount ,
   pre.Note = @Note ,
   pre.BV = @BV ,
   pre.Bonus = @Bonus
FROM Prepaid AS pre
WHERE pre.PrepaidID = @PrepaidID

GO