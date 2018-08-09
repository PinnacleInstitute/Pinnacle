EXEC [dbo].pts_CheckProc 'pts_Payout_WalletStatus'
GO

--DECLARE @Count int EXEC pts_Payout_WalletStatus 17, '1/3/15', 14, @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Payout_WalletStatus
   @CompanyID int ,
   @PayDate datetime ,
   @PayType datetime ,
   @Count int OUTPUT
AS
-- **************************************************************************************************
-- Wallet - Mark Paid All Pending Payouts Complete
-- **************************************************************************************************
SET NOCOUNT ON
DECLARE @Today datetime
SET @Today = dbo.wtfn_DateOnly( GETDATE())

SELECT @Count = COUNT(*) FROM Payout WHERE CompanyID = @CompanyID AND PayType = @PayType AND Status = 4 AND PayDate <= @PayDate

UPDATE Payout SET Status = 1, PaidDate = @Today WHERE CompanyID = @CompanyID AND PayType = @PayType AND Status = 4 AND PayDate <= @PayDate

GO

