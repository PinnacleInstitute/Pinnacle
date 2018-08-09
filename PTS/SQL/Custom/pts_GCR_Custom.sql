EXEC [dbo].pts_CheckProc 'pts_GCR_Custom'
GO

--declare @Result varchar(1000) EXEC pts_GCR_Custom 1, 0, 12046, 0, @Result output print @Result

CREATE PROCEDURE [dbo].pts_GCR_Custom
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int
SET @CompanyID = 17

-- *******************************************************************
-- Calculate downline personal and group sales volumes 
-- *******************************************************************
IF @Status = 1
BEGIN
	EXEC pts_GCR_Sales @Result OUTPUT
	EXEC pts_GCR_Sales2 @Result OUTPUT
END 

-- *******************************************************************
-- Post Monthly Sales in the Member Sales Summary
-- *******************************************************************
--IF @Status = 2 EXEC pts_GCR_SalesSummary @czDate, @Result OUTPUT

-- *******************************************************************
-- Specify qualified member's that can receive bonuses
-- *******************************************************************
IF @Status = 3 EXEC pts_GCR_Qualified 1, @czDate, @Result OUTPUT

-- *******************************************************************
-- Specify qualified member's that can receive a payout
-- *******************************************************************
IF @Status = 6 EXEC pts_GCR_Qualified 2, @czDate, @Result OUTPUT

-- *******************************************************************
-- Business Stats
-- *******************************************************************
IF @Status = 7 EXEC pts_GCR_Stats @Quantity, @Result OUTPUT

-- *******************************************************************
-- Member Dashboard
-- *******************************************************************
IF @Status = 8 EXEC pts_GCR_Dashboard @Quantity, @Result OUTPUT

-- *******************************************************************
-- Calculate title demotions
-- *******************************************************************
--IF @Status = 9 EXEC pts_GCR_Demote 0, @Result OUTPUT

-- *******************************************************************
-- Cancel all Free Trial Customers over 30 Days
-- *******************************************************************
--IF @Status = 10 EXEC pts_GCR_ExpiredFreeTrial @Result OUTPUT

-- *******************************************************************
-- Set Member Alerts
-- *******************************************************************
IF @Status = 11 EXEC pts_GCR_Alerts @Quantity, @Result OUTPUT

-- *******************************************************************
-- Support Stats
-- *******************************************************************
IF @Status = 12 EXEC pts_GCR_StatsSupport @Quantity, @Amount, @Result OUTPUT

-- *******************************************************************
-- Adjust affiliate computers for OverDraft Protection
-- *******************************************************************
--IF @Status = 13 EXEC pts_GCR_OverDraft @Result OUTPUT

-- *******************************************************************
-- find the next active upline sponsor and return MemberID
-- *******************************************************************
--IF @Status = 14 EXEC pts_GCR_Sponsor @Quantity, @Result OUTPUT

-- *******************************************************************
-- check for possible advancement for an Affiliate
-- *******************************************************************
IF @Status = 15 EXEC pts_Commission_CalcAdvancement_17 @Quantity, 0, @Result OUTPUT

-- *******************************************************************
-- Income Estimator
-- *******************************************************************
--IF @Status = 16 EXEC pts_GCR_Income @czDate, @Quantity, @Result OUTPUT

-- *******************************************************************
-- PayPal Payment
-- *******************************************************************
--IF @Status = 17 EXEC pts_GCR_PayPal @Quantity, @Result OUTPUT

-- *******************************************************************
-- Prepaid Services Summary
-- *******************************************************************
--IF @Status = 18 EXEC pts_GCR_Prepaid @Quantity, @Result OUTPUT

-- *******************************************************************
-- New Member Activation
-- *******************************************************************
IF @Status = 100 EXEC pts_GCR_NewMember @Quantity, @Result OUTPUT

-- *******************************************************************
-- Update change in Group Sales Volume
-- *******************************************************************
IF @Status = 101 EXEC pts_GCR_SetTotals @Quantity, @Amount, 0, @Result output

-- *******************************************************************
-- Upgrade Customer to Affiliate
-- *******************************************************************
IF @Status = 102 EXEC pts_GCR_Upgrade @Quantity, @Result OUTPUT

-- *******************************************************************
-- Cancelled Affiliate
-- *******************************************************************
--IF @Status = 103 EXEC pts_GCR_Cancel @Quantity, @Result OUTPUT

-- *******************************************************************
-- Get Upline Leader's Emails
-- *******************************************************************
--IF @Status = 104 EXEC pts_GCR_LeaderEmails @Quantity, @Result OUTPUT

-- *******************************************************************
-- Create GCC Payments from earnings for Intl. Affiliates
-- *******************************************************************
--IF @Status = 105 EXEC pts_GCR_NeweWallets @Result OUTPUT

-- *******************************************************************
-- Mark GCC Payments in process (2=pending)
-- *******************************************************************
--IF @Status = 106 UPDATE Payment SET Status = 2 WHERE Status = 1 AND Reference = 'GCC'

-- *******************************************************************
-- Create Payments
-- *******************************************************************
IF @Status = 200
BEGIN
	EXEC pts_GCR_Payments @czDate, @Result OUTPUT
	EXEC pts_GCR_PaymentPurge 
END
-- *******************************************************************
-- Create Member Payment
-- *******************************************************************
IF @Status = 202 EXEC pts_GCR_PaymentMember @Quantity, 0,0,0,0,0,'', @Result OUTPUT

-- *******************************************************************
-- Update Binary Sales
-- *******************************************************************
--IF @Status = 201 EXEC pts_GCR_PaymentsBinary @Result OUTPUT

-- *******************************************************************
-- Calculate downline personal and group sales volumes 
-- *******************************************************************
--IF @Status = 301 EXEC pts_GCR_SalesB @Result OUTPUT

-- *******************************************************************
-- Calculate downline personal and group sales volumes 
-- *******************************************************************
IF @Status = 302 
BEGIN
	EXEC pts_GCR_CancelTrial @Result OUTPUT
	EXEC pts_GCR_Sales @Result OUTPUT
	EXEC pts_GCR_Sales2 @Result OUTPUT
END 

-- *******************************************************************
-- Update a pending payment if the member changes his auto-ship option
-- *******************************************************************
IF @Status = 303 EXEC pts_GCR_UpdatePendingPayment @Quantity, @Result OUTPUT

-- *******************************************************************
-- Update a pending payment if the member changes his auto-ship option
-- *******************************************************************
IF @Status = 304 EXEC pts_GCR_LockPayouts @Quantity, @Result OUTPUT

-- *******************************************************************
-- Process Trial Member
-- *******************************************************************
IF @Status = 305 
BEGIN
	DECLARE @PaymentID int, @MemberID int
	SET @PaymentID = @Quantity
	SET @MemberID = @Amount
	EXEC pts_GCR_TrialActivate @PaymentID, @MemberID 
	EXEC pts_GCR_QualifiedMember @MemberID, 1, 0, @Result OUTPUT 
	EXEC pts_GCR_TrialPlacement @MemberID 
END 

-- *******************************************************************
-- Mining Coins Update Status distributed
-- *******************************************************************
IF @Status = 400 UPDATE Mining SET Status = 1 WHERE MiningID = @Quantity 

-- *******************************************************************
-- Get member current payment
-- *******************************************************************
IF @Status = 500 EXEC pts_GCR_MemberPayment @Quantity, @Result OUTPUT 

-- *******************************************************************
-- Get member product
-- *******************************************************************
IF @Status = 501 EXEC pts_GCR_MemberProduct @Quantity, @Amount, @Result OUTPUT 

GO