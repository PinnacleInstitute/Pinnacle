EXEC [dbo].pts_CheckProc 'pts_Statement_Update'
 GO

CREATE PROCEDURE [dbo].pts_Statement_Update ( 
   @StatementID int,
   @CompanyID int,
   @MerchantID int,
   @StatementDate datetime,
   @PaidDate datetime,
   @Amount money,
   @Status int,
   @PayType int,
   @Reference varchar (30),
   @Notes varchar (500),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE stm
SET stm.CompanyID = @CompanyID ,
   stm.MerchantID = @MerchantID ,
   stm.StatementDate = @StatementDate ,
   stm.PaidDate = @PaidDate ,
   stm.Amount = @Amount ,
   stm.Status = @Status ,
   stm.PayType = @PayType ,
   stm.Reference = @Reference ,
   stm.Notes = @Notes
FROM Statement AS stm
WHERE stm.StatementID = @StatementID

GO