EXEC [dbo].pts_CheckProc 'pts_Legacy_Custom'
GO

--declare @Result varchar(1000) EXEC pts_Legacy_Custom 301, 0, 7150, 0, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Legacy_Custom
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int
SET @CompanyID = 14

-- *******************************************************************
-- Calculate downline personal and group sales volumes 
-- *******************************************************************
IF @Status = 1
BEGIN
	EXEC pts_Legacy_Sales @Result OUTPUT
	EXEC pts_Legacy_Sales2 @Result OUTPUT
END 

-- *******************************************************************
-- Post Monthly Sales in the Member Sales Summary
-- *******************************************************************
--IF @Status = 2 EXEC pts_Legacy_SalesSummary @czDate, @Result OUTPUT

-- *******************************************************************
-- Specify qualified member's that can receive bonuses
-- *******************************************************************
IF @Status = 3 EXEC pts_Legacy_Qualified 1, @czDate, @Result OUTPUT

-- *******************************************************************
-- Specify qualified member's that can receive a payout
-- *******************************************************************
IF @Status = 6 EXEC pts_Legacy_Qualified 2, @czDate, @Result OUTPUT

-- *******************************************************************
-- Business Stats
-- *******************************************************************
IF @Status = 7 EXEC pts_Legacy_Stats @Quantity, @Result OUTPUT

-- *******************************************************************
-- Member Dashboard
-- *******************************************************************
IF @Status = 8 EXEC pts_Legacy_Dashboard @Quantity, @Result OUTPUT

-- *******************************************************************
-- Calculate title demotions
-- *******************************************************************
--IF @Status = 9 EXEC pts_Legacy_Demote 0, @Result OUTPUT

-- *******************************************************************
-- Cancel all Free Trial Customers over 30 Days
-- *******************************************************************
--IF @Status = 10 EXEC pts_Legacy_ExpiredFreeTrial @Result OUTPUT

-- *******************************************************************
-- Set Member Alerts
-- *******************************************************************
IF @Status = 11 EXEC pts_Legacy_Alerts @Quantity, @Result OUTPUT

-- *******************************************************************
-- Adjust affiliate computers for OverDraft Protection
-- *******************************************************************
--IF @Status = 13 EXEC pts_Legacy_OverDraft @Result OUTPUT

-- *******************************************************************
-- find the next active upline sponsor and return MemberID
-- *******************************************************************
--IF @Status = 14 EXEC pts_Legacy_Sponsor @Quantity, @Result OUTPUT

-- *******************************************************************
-- check for possible advancement for an Affiliate
-- *******************************************************************
IF @Status = 15 EXEC pts_Commission_CalcAdvancement_14 @Quantity, 0, @Result OUTPUT

-- *******************************************************************
-- Income Estimator
-- *******************************************************************
--IF @Status = 16 EXEC pts_Legacy_Income @czDate, @Quantity, @Result OUTPUT

-- *******************************************************************
-- PayPal Payment
-- *******************************************************************
--IF @Status = 17 EXEC pts_Legacy_PayPal @Quantity, @Result OUTPUT

-- *******************************************************************
-- Prepaid Services Summary
-- *******************************************************************
--IF @Status = 18 EXEC pts_Legacy_Prepaid @Quantity, @Result OUTPUT

-- *******************************************************************
-- New Member Activation
-- *******************************************************************
IF @Status = 100 EXEC pts_Legacy_NewMember @Quantity, @Result OUTPUT

-- *******************************************************************
-- Update change in Group Sales Volume
-- *******************************************************************
IF @Status = 101 EXEC pts_Legacy_SetTotals @Quantity, @Amount, 0, @Result output

-- *******************************************************************
-- Upgrade Customer to Affiliate
-- *******************************************************************
IF @Status = 102 EXEC pts_Legacy_Upgrade @Quantity, @Result OUTPUT

-- *******************************************************************
-- Cancelled Affiliate
-- *******************************************************************
--IF @Status = 103 EXEC pts_Legacy_Cancel @Quantity, @Result OUTPUT

-- *******************************************************************
-- Get Upline Leader's Emails
-- *******************************************************************
--IF @Status = 104 EXEC pts_Legacy_LeaderEmails @Quantity, @Result OUTPUT

-- *******************************************************************
-- Create GCC Payments from earnings for Intl. Affiliates
-- *******************************************************************
IF @Status = 105 EXEC pts_Legacy_NeweWallets @Result OUTPUT

-- *******************************************************************
-- Mark GCC Payments in process (2=pending)
-- *******************************************************************
--IF @Status = 106 UPDATE Payment SET Status = 2 WHERE Status = 1 AND Reference = 'GCC'

-- *******************************************************************
-- Create Payments
-- *******************************************************************
IF @Status = 200 EXEC pts_Legacy_Payments @czDate, @Result OUTPUT

-- *******************************************************************
-- Update Binary Sales
-- *******************************************************************
IF @Status = 201 EXEC pts_Legacy_PaymentsBinary @Result OUTPUT

-- *******************************************************************
-- Calculate downline personal and group sales volumes 
-- *******************************************************************
IF @Status = 301 EXEC pts_Legacy_SalesB @Result OUTPUT


GO