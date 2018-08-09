EXEC [dbo].pts_CheckProc 'pts_Payout_CompanyStatus3'
GO

--DECLARE @Count int
--EXEC pts_Payout_CompanyStatus3 17, '12/31/14', @Count OUTPUT
--PRINT @Count

CREATE PROCEDURE [dbo].pts_Payout_CompanyStatus3
   @CompanyID int ,
   @PayDate datetime ,
   @Count int OUTPUT
AS
-- **************************************************************************************************
-- Wallet - Mark Paid All Pending Payouts Complete
-- **************************************************************************************************
SET NOCOUNT ON

SELECT @Count = COUNT(*) FROM Payout WHERE CompanyID = @CompanyID AND Status = 4 AND PayDate <= @PayDate

UPDATE Payout SET Status = 1 WHERE CompanyID = @CompanyID AND Status = 4 AND PayDate <= @PayDate

GO
