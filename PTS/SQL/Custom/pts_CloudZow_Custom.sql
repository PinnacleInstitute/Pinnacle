EXEC [dbo].pts_CheckProc 'pts_CloudZow_Custom'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_Custom 14, 0, 1704, 0, @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_Custom
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int
SET @CompanyID = 5

-- *******************************************************************
-- Calculate downline personal and group sales volumes 
-- *******************************************************************
IF @Status = 1 EXEC pts_CloudZow_Sales @Result OUTPUT

-- *******************************************************************
-- Post Monthly Sales in the Member Sales Summary
-- *******************************************************************
IF @Status = 2 EXEC pts_CloudZow_SalesSummary @czDate, @Result OUTPUT

-- *******************************************************************
-- Specify qualified member's that can receive bonuses
-- *******************************************************************
IF @Status = 3 EXEC pts_CloudZow_Qualified 1, @czDate, @Result OUTPUT

-- *******************************************************************
-- Create Payment Credits from unpaid commissions
-- *******************************************************************
IF @Status = 4 EXEC pts_CloudZow_PaymentCredit @Result OUTPUT

-- *******************************************************************
-- Create individual Payment Credit
-- *******************************************************************
IF @Status = 5
BEGIN
	EXEC pts_Payment_CreditPayment @CompanyID, @Quantity 
	SET @Result = '1'
END	
 
-- *******************************************************************
-- Specify qualified member's that can receive a payout
-- *******************************************************************
IF @Status = 6 EXEC pts_CloudZow_Qualified 2, @czDate, @Result OUTPUT

-- *******************************************************************
-- Enrollment and Computer Stats
-- *******************************************************************
IF @Status = 7 EXEC pts_CloudZow_Stats @Quantity, @Result OUTPUT

-- *******************************************************************
-- Reclaim Payment Commissions
-- *******************************************************************
IF @Status = 8 EXEC pts_CloudZow_Reclaim @Quantity, @Result OUTPUT

-- *******************************************************************
-- Calculate title demotions
-- *******************************************************************
IF @Status = 9 EXEC pts_CloudZow_Demote 0, @Result OUTPUT

-- *******************************************************************
-- Cancel all Free Trial Customers over 30 Days
-- *******************************************************************
IF @Status = 10 EXEC pts_CloudZow_ExpiredFreeTrial @Result OUTPUT

-- *******************************************************************
-- Set Member Alerts
-- *******************************************************************
IF @Status = 11 EXEC pts_CloudZow_Alerts @Quantity, @Result OUTPUT

-- *******************************************************************
-- Clean Up Data
-- *******************************************************************
IF @Status = 12 EXEC pts_CloudZow_Clean @Result OUTPUT

-- *******************************************************************
-- Adjust affiliate computers for OverDraft Protection
-- *******************************************************************
IF @Status = 13 EXEC pts_CloudZow_OverDraft @Result OUTPUT

-- *******************************************************************
-- find the next active upline sponsor and return MemberID
-- *******************************************************************
IF @Status = 14 EXEC pts_CloudZow_Sponsor @Quantity, @Result OUTPUT

-- *******************************************************************
-- check for possible advancement for an Affiliate
-- *******************************************************************
IF @Status = 15 EXEC pts_Commission_CalcAdvancement_5 @Quantity, 0, @Result OUTPUT

-- *******************************************************************
-- Income Estimator
-- *******************************************************************
IF @Status = 16 EXEC pts_CloudZow_Income @czDate, @Quantity, @Result OUTPUT

-- *******************************************************************
-- PayPal Payment
-- *******************************************************************
IF @Status = 17 EXEC pts_CloudZow_PayPal @Quantity, @Result OUTPUT

-- *******************************************************************
-- Prepaid Services Summary
-- *******************************************************************
IF @Status = 18 EXEC pts_CloudZow_Prepaid @Quantity, @Result OUTPUT

-- *******************************************************************
-- New Affiliate/Customer Activation
-- *******************************************************************
IF @Status = 100 EXEC pts_CloudZow_NewMember @Quantity, @Result OUTPUT

-- *******************************************************************
-- Update change in Group Sales Volume
-- *******************************************************************
IF @Status = 101 EXEC pts_CloudZow_Sale @Quantity, @Amount, @Result OUTPUT

-- *******************************************************************
-- Upgrade Customer to Affiliate
-- *******************************************************************
IF @Status = 102 EXEC pts_CloudZow_Upgrade @Quantity, @Amount, @Result OUTPUT

-- *******************************************************************
-- Cancelled Affiliate
-- *******************************************************************
IF @Status = 103 EXEC pts_CloudZow_Cancel @Quantity, @Result OUTPUT

-- *******************************************************************
-- Get Upline Leader's Emails
-- *******************************************************************
IF @Status = 104 EXEC pts_CloudZow_LeaderEmails @Quantity, @Result OUTPUT

-- *******************************************************************
-- Create GCC Payments from earnings for Intl. Affiliates
-- *******************************************************************
IF @Status = 105 EXEC pts_CloudZow_NeweWallets @Result OUTPUT

-- *******************************************************************
-- Mark GCC Payments in process (2=pending)
-- *******************************************************************
--IF @Status = 106 UPDATE Payment SET Status = 2 WHERE Status = 1 AND Reference = 'GCC'

-- *******************************************************************
-- Create Payments
-- *******************************************************************
IF @Status = 200 EXEC pts_CloudZow_Payments @czDate, @Result OUTPUT

-- *******************************************************************
-- Update Declined Payments
-- *******************************************************************
IF @Status = 201 EXEC pts_CloudZow_UpdateBadPayments @Result OUTPUT

-- *******************************************************************
-- Show All newly created Commissions (Show=1)
-- *******************************************************************
IF @Status = 202 UPDATE Commission SET Show = 0 WHERE Show = 1 AND CompanyID = @CompanyID

-- *******************************************************************
-- Show All newly created Payouts (Show=1)
-- *******************************************************************
IF @Status = 203 UPDATE Payout SET Show = 0 WHERE Show = 1 AND CompanyID = @CompanyID

-- *******************************************************************
-- Move an Affiliate's Sponsor Downline to the specified Sponsor
-- *******************************************************************
IF @Status = 204 UPDATE Member SET SponsorID = @Amount, MentorID = @Amount WHERE SponsorID = @Quantity AND Status <=5

GO