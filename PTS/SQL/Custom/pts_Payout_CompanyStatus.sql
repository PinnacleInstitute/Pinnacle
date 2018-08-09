EXEC [dbo].pts_CheckProc 'pts_Payout_CompanyStatus'
GO

CREATE PROCEDURE [dbo].pts_Payout_CompanyStatus
   @CompanyID int ,
   @PayDate datetime ,
   @Amount money ,
   @PaidDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

SELECT @Count = COUNT(PayoutID) FROM Payout 
WHERE CompanyID = @CompanyID AND Status = 1 AND PayDate = @PayDate AND Amount >= @Amount

UPDATE Payout SET Status = 2, PaidDate = @PaidDate 
WHERE CompanyID = @CompanyID AND Status = 1 AND PayDate = @PayDate AND Amount >= @Amount

GO
