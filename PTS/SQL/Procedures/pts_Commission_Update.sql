EXEC [dbo].pts_CheckProc 'pts_Commission_Update'
 GO

CREATE PROCEDURE [dbo].pts_Commission_Update ( 
   @CommissionID int,
   @CompanyID int,
   @OwnerType int,
   @OwnerID int,
   @PayoutID int,
   @RefID int,
   @CommDate datetime,
   @Status int,
   @CommType int,
   @Amount money,
   @Total money,
   @Charge money,
   @Description varchar (100),
   @Notes varchar (500),
   @Show int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE co
SET co.CompanyID = @CompanyID ,
   co.OwnerType = @OwnerType ,
   co.OwnerID = @OwnerID ,
   co.PayoutID = @PayoutID ,
   co.RefID = @RefID ,
   co.CommDate = @CommDate ,
   co.Status = @Status ,
   co.CommType = @CommType ,
   co.Amount = @Amount ,
   co.Total = @Total ,
   co.Charge = @Charge ,
   co.Description = @Description ,
   co.Notes = @Notes ,
   co.Show = @Show
FROM Commission AS co
WHERE co.CommissionID = @CommissionID

GO