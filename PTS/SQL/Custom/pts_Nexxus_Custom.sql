EXEC [dbo].pts_CheckProc 'pts_Nexxus_Custom'
GO

--declare @Result varchar(1000) EXEC pts_Nexxus_Custom 500, 0, 37702, 0, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_Custom
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int
SET @CompanyID = 21

-- *******************************************************************
-- Calculate downline personal and group sales volumes 
-- *******************************************************************
IF @Status = 1
BEGIN
	EXEC pts_Nexxus_Sales
END 

-- *******************************************************************
-- Post Monthly Sales in the Member Sales Summary
-- *******************************************************************
--IF @Status = 2 EXEC pts_Nexxus_SalesSummary @czDate, @Result OUTPUT

-- *******************************************************************
-- Specify qualified member's that can receive bonuses
-- *******************************************************************
IF @Status = 3 EXEC pts_Nexxus_Qualified 1, @czDate, @Result OUTPUT

-- *******************************************************************
-- Specify qualified member's that can receive a payout
-- *******************************************************************
IF @Status = 6 EXEC pts_Nexxus_Qualified 2, @czDate, @Result OUTPUT

-- *******************************************************************
-- Business Stats
-- *******************************************************************
IF @Status = 7 EXEC pts_Nexxus_Stats @Quantity, @Result OUTPUT

-- *******************************************************************
-- Member Dashboard
-- *******************************************************************
IF @Status = 8 EXEC pts_Nexxus_Dashboard @Quantity, @Result OUTPUT

-- *******************************************************************
-- Merchant Dashboard
-- *******************************************************************
IF @Status = 28 EXEC pts_Nexxus_Dashboard_Merchant @Quantity, @Result OUTPUT

-- *******************************************************************
-- Org Dashboard
-- *******************************************************************
IF @Status = 29 EXEC pts_Nexxus_Dashboard_Org @Quantity, @Result OUTPUT

-- *******************************************************************
-- Consumer Dashboard
-- *******************************************************************
IF @Status = 38 EXEC pts_Nexxus_Dashboard_Consumer @Quantity, @Result OUTPUT

-- *******************************************************************
-- Calculate title demotions
-- *******************************************************************
--IF @Status = 9 EXEC pts_Nexxus_Demote 0, @Result OUTPUT

-- *******************************************************************
-- Cancel all Free Trial Customers over 30 Days
-- *******************************************************************
--IF @Status = 10 EXEC pts_Nexxus_ExpiredFreeTrial @Result OUTPUT

-- *******************************************************************
-- Set Member Alerts
-- *******************************************************************
IF @Status = 11 EXEC pts_Nexxus_Alerts @Quantity, @Result OUTPUT

-- *******************************************************************
-- Support Stats
-- *******************************************************************
IF @Status = 12 EXEC pts_Nexxus_StatsSupport @Quantity, @Amount, @Result OUTPUT

-- *******************************************************************
-- Adjust affiliate computers for OverDraft Protection
-- *******************************************************************
--IF @Status = 13 EXEC pts_Nexxus_OverDraft @Result OUTPUT

-- *******************************************************************
-- find the next active upline sponsor and return MemberID
-- *******************************************************************
--IF @Status = 14 EXEC pts_Nexxus_Sponsor @Quantity, @Result OUTPUT

-- *******************************************************************
-- check for possible advancement for an Affiliate
-- *******************************************************************
IF @Status = 15 EXEC pts_Commission_CalcAdvancement_21 @Quantity, 0, @Result OUTPUT

-- *******************************************************************
-- Income Estimator
-- *******************************************************************
--IF @Status = 16 EXEC pts_Nexxus_Income @czDate, @Quantity, @Result OUTPUT

-- *******************************************************************
-- PayPal Payment
-- *******************************************************************
--IF @Status = 17 EXEC pts_Nexxus_PayPal @Quantity, @Result OUTPUT

-- *******************************************************************
-- Prepaid Services Summary
-- *******************************************************************
--IF @Status = 18 EXEC pts_Nexxus_Prepaid @Quantity, @Result OUTPUT

-- *******************************************************************
-- New Member Activation
-- *******************************************************************
IF @Status = 100 EXEC pts_Nexxus_NewMember @Quantity, @Result OUTPUT

-- *******************************************************************
-- Update change in Group Sales Volume
-- *******************************************************************
IF @Status = 101 EXEC pts_Nexxus_SetTotals @Quantity, @Amount, 0, @Result output

-- *******************************************************************
-- Upgrade Customer to Affiliate
-- *******************************************************************
IF @Status = 102 EXEC pts_Nexxus_Upgrade @Quantity, @Result OUTPUT

-- *******************************************************************
-- Cancelled Affiliate
-- *******************************************************************
--IF @Status = 103 EXEC pts_Nexxus_Cancel @Quantity, @Result OUTPUT

-- *******************************************************************
-- Get Upline Leader's Emails
-- *******************************************************************
--IF @Status = 104 EXEC pts_Nexxus_LeaderEmails @Quantity, @Result OUTPUT

-- *******************************************************************
-- Create GCC Payments from earnings for Intl. Affiliates
-- *******************************************************************
--IF @Status = 105 EXEC pts_Nexxus_NeweWallets @Result OUTPUT

-- *******************************************************************
-- Mark GCC Payments in process (2=pending)
-- *******************************************************************
--IF @Status = 106 UPDATE Payment SET Status = 2 WHERE Status = 1 AND Reference = 'GCC'

-- *******************************************************************
-- Create Payments
-- *******************************************************************
IF @Status = 200
BEGIN
	EXEC pts_Nexxus_Payments @czDate, @Result OUTPUT
END
-- *******************************************************************
-- Create Member Payment
-- *******************************************************************
IF @Status = 202 EXEC pts_Nexxus_PaymentMember @Quantity, 0,0,0,0,0,'', @Result OUTPUT

-- *******************************************************************
-- Update Binary Sales
-- *******************************************************************
--IF @Status = 201 EXEC pts_Nexxus_PaymentsBinary @Result OUTPUT

-- *******************************************************************
-- Calculate downline personal and group sales volumes 
-- *******************************************************************
--IF @Status = 301 EXEC pts_Nexxus_SalesB @Result OUTPUT

-- *******************************************************************
-- Calculate downline personal and group sales volumes 
-- *******************************************************************
IF @Status = 302 
BEGIN
	EXEC pts_Nexxus_Sales @Result OUTPUT
	EXEC pts_Nexxus_Sales2 @Result OUTPUT
END 

-- *******************************************************************
-- Update a pending payment if the member changes his auto-ship option
-- *******************************************************************
--IF @Status = 303 EXEC pts_Nexxus_UpdatePendingPayment @Quantity, @Result OUTPUT

-- *******************************************************************
-- Update a pending payment if the member changes his auto-ship option
-- *******************************************************************
IF @Status = 304 EXEC pts_Nexxus_LockPayouts @Quantity, @Result OUTPUT

-- *******************************************************************
-- Get member current payment
-- *******************************************************************
IF @Status = 500 EXEC pts_Nexxus_MemberPayment @Quantity, @Result OUTPUT 

-- *******************************************************************
-- Get member product
-- *******************************************************************
IF @Status = 501 EXEC pts_Nexxus_MemberProduct @Quantity, @Result OUTPUT 

-- *******************************************************************
-- Delete All Marketing IP AuthLog records
-- *******************************************************************
IF @Status = 502 DELETE AuthLog WHERE AuthUserID = -1

-- *******************************************************************
-- Bonus and Payout Qualify a specific member
-- *******************************************************************
IF @Status = 503
BEGIN
	EXEC pts_Nexxus_QualifiedMember @Quantity, 1, 0, @Result output
	EXEC pts_Nexxus_QualifiedMember @Quantity, 2, 0, @Result output
END

-- *******************************************************************
-- Consolidate Product Certificates
-- *******************************************************************
IF @Status = 600 EXEC pts_Nexxus_GiftCount @Quantity, @Amount, @Result output

-- *******************************************************************
-- Consolidate Product Certificates
-- *******************************************************************
IF @Status IN (601,602,603) EXEC pts_Nexxus_GiftConsolidate @Status, @Quantity, @Amount, @Result output

-- *******************************************************************
-- Split Product Certificates
-- *******************************************************************
IF @Status IN (611,612,613) EXEC pts_Nexxus_GiftSplit @Status, @Quantity, @Amount, @Result output

-- *******************************************************************
-- Create Merchant Statements
-- *******************************************************************
IF @Status = 700 EXEC pts_Nexxus_Statements @Result OUTPUT 

-- *******************************************************************
-- Mark Merchant ACH Statements pending
-- *******************************************************************
IF @Status = 701 EXEC pts_Statement_SetPending @CompanyID, 1, @Result OUTPUT 

-- *******************************************************************
-- Release Onhold Rewards
-- *******************************************************************
IF @Status = 702 EXEC pts_Nexxus_ReleaseRewards @Result OUTPUT 

-- *******************************************************************
-- Process Good Invoices
-- *******************************************************************
IF @Status = 703 EXEC pts_Nexxus_StatementsPending @Result OUTPUT 

-- *******************************************************************
-- Payment2 Post Processing
-- *******************************************************************
IF @Status = 799 EXEC pts_Nexxus_Payment2Post @Quantity, @Result OUTPUT 

GO