EXEC [dbo].pts_CheckProc 'pts_Payout_Update'
 GO

CREATE PROCEDURE [dbo].pts_Payout_Update ( 
   @PayoutID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE po
SET po.CompanyID = @CompanyID ,
   po.OwnerType = @OwnerType ,
   po.OwnerID = @OwnerID ,
   po.PayDate = @PayDate ,
   po.PaidDate = @PaidDate ,
   po.Amount = @Amount ,
   po.Status = @Status ,
   po.Notes = @Notes ,
   po.PayType = @PayType ,
   po.Reference = @Reference ,
   po.Show = @Show
FROM Payout AS po
WHERE po.PayoutID = @PayoutID

GO