EXEC [dbo].pts_CheckProc 'pts_Statement_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Statement_Fetch ( 
   @StatementID int,
   @CompanyID int OUTPUT,
   @MerchantID int OUTPUT,
   @MerchantName nvarchar (80) OUTPUT,
   @StatementDate datetime OUTPUT,
   @PaidDate datetime OUTPUT,
   @Amount money OUTPUT,
   @Status int OUTPUT,
   @PayType int OUTPUT,
   @Reference varchar (30) OUTPUT,
   @Notes varchar (500) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = stm.CompanyID ,
   @MerchantID = stm.MerchantID ,
   @MerchantName = mer.MerchantName ,
   @StatementDate = stm.StatementDate ,
   @PaidDate = stm.PaidDate ,
   @Amount = stm.Amount ,
   @Status = stm.Status ,
   @PayType = stm.PayType ,
   @Reference = stm.Reference ,
   @Notes = stm.Notes
FROM Statement AS stm (NOLOCK)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (stm.MerchantID = mer.MerchantID)
WHERE stm.StatementID = @StatementID

GO