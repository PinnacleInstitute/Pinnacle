EXEC [dbo].pts_CheckProc 'pts_Cash_Update'
 GO

CREATE PROCEDURE [dbo].pts_Cash_Update ( 
   @CashID int,
   @MemberID int,
   @RefID int,
   @CashDate datetime,
   @CashType int,
   @Amount money,
   @Note varchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE cas
SET cas.MemberID = @MemberID ,
   cas.RefID = @RefID ,
   cas.CashDate = @CashDate ,
   cas.CashType = @CashType ,
   cas.Amount = @Amount ,
   cas.Note = @Note
FROM Cash AS cas
WHERE cas.CashID = @CashID

GO