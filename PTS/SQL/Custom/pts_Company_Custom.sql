EXEC [dbo].pts_CheckProc 'pts_Company_Custom'
GO

--DECLARE @Result int EXEC pts_Company_Custom 17, 305, 0, 97646,31979 , @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Company_Custom
   @CompanyID int ,
   @Status int ,
   @EnrollDate datetime ,
   @Quantity int ,
   @Amount int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

-- *******************************************************************
-- Create Payment Credits from unpaid commissions
-- *******************************************************************
IF @Status = 4 EXEC pts_Pinnacle_PaymentCredit @CompanyID, @Quantity, @Result OUTPUT

-- *******************************************************************
-- Create individual Payment Credit
-- *******************************************************************
IF @Status = 5 BEGIN EXEC pts_Payment_CreditPayment @CompanyID, @Quantity SET @Result = '1' END	
 
-- *******************************************************************
-- Reclaim Payment Commissions
-- *******************************************************************
IF @Status = 8 EXEC pts_Pinnacle_Reclaim @Quantity, @Result OUTPUT

-- *******************************************************************
-- Clean Up Data
-- *******************************************************************
IF @Status = 12 EXEC pts_Pinnacle_Clean @Result OUTPUT

-- *******************************************************************
-- find the next active upline sponsor and return MemberID
-- *******************************************************************
IF @Status = 14 EXEC pts_Pinnacle_Referrer @Quantity, @Result OUTPUT

-- *******************************************************************
-- Process a payment from the Member's Wallet
-- *******************************************************************
IF @Status = 98 EXEC pts_Pinnacle_WalletPayment @Quantity, @Amount, @Result OUTPUT

-- *******************************************************************
-- Post Payment Processing
-- *******************************************************************
IF @Status = 99
BEGIN
	IF @CompanyID = 9 EXEC pts_ZaZZed_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 10 EXEC pts_Silver_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 11 EXEC pts_PB_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 13 EXEC pts_GFTG_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 14 EXEC pts_Legacy_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 15 EXEC pts_CIS_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 16 EXEC pts_PeopleEdge_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 17 EXEC pts_GCR_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 18 EXEC pts_FreeLoyalty_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 19 EXEC pts_TellAll_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 20 EXEC pts_SilverHeart_PaymentPost @Quantity, @Result OUTPUT 
	IF @CompanyID = 21 EXEC pts_Nexxus_PaymentPost @Quantity, @Result OUTPUT 
END

-- *******************************************************************
-- Pending Payment Processing
-- *******************************************************************
IF @Status = 305
BEGIN
	IF @CompanyID = 17 EXEC pts_GCR_Custom @Status, @EnrollDate, @Quantity, @Amount, @Result OUTPUT
END

-- *******************************************************************
-- Activate New Member
-- *******************************************************************
IF @Status = 100
BEGIN
	IF @CompanyID = 7 EXEC pts_SIMS_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 8 EXEC pts_LifeTime_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 9 EXEC pts_ZaZZed_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 10 EXEC pts_Silver_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 11 EXEC pts_PB_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 13 EXEC pts_GFTG_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 14 EXEC pts_Legacy_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 15 EXEC pts_CIS_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 16 EXEC pts_PeopleEdge_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 17 EXEC pts_GCR_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 18 EXEC pts_FreeLoyalty_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 19 EXEC pts_TellAll_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 20 EXEC pts_SilverHeart_NewMember @Quantity, @Result OUTPUT
	IF @CompanyID = 21 EXEC pts_Nexxus_NewMember @Quantity, @Result OUTPUT
END

-- *******************************************************************
-- Update Declined Payments
-- *******************************************************************
IF @Status = 201 EXEC pts_Pinnacle_UpdateBadPayments @CompanyID, @Result OUTPUT

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
IF @Status = 204 EXEC pts_Pinnacle_Orphans @Quantity, 0, @Result OUTPUT 

-- *******************************************************************
-- Count the number of members on a Sponsor team
-- *******************************************************************
IF @Status = 205 EXEC pts_Pinnacle_CountSponsor @Quantity, @Amount, @Result OUTPUT

-- *******************************************************************
-- Validate Sponsor3ID is under ReferralID
-- *******************************************************************
IF @Status = 206 EXEC pts_Pinnacle_ValidSponsor3 @Quantity, @Amount, @Result OUTPUT

-- *******************************************************************
-- Suspend Members with Declined Payments
-- *******************************************************************
IF @Status = 207 EXEC pts_Pinnacle_DeclineSuspend @CompanyID, @EnrollDate, @Result OUTPUT

-- *******************************************************************
-- Cancel Members that were Suspended with Declined payments
-- *******************************************************************
IF @Status = 208 EXEC pts_Pinnacle_DeclineCancel @CompanyID, @EnrollDate, @Result OUTPUT

-- *******************************************************************
-- ReSubmit Declined Payments 
-- *******************************************************************
IF @Status = 209 EXEC pts_Pinnacle_DeclineSubmit @CompanyID, @EnrollDate, @Result OUTPUT

-- *******************************************************************
-- Reconcile Company Wallets 
-- *******************************************************************
IF @Status = 210 EXEC pts_Pinnacle_ReconcileWallet @CompanyID, @Result OUTPUT

GO
