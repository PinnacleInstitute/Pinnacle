EXEC [dbo].pts_CheckProc 'pts_Commission_Company_21a'
GO
--DECLARE @Count int EXEC pts_Commission_Company_21a 173719, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 173719
--delete commission where refid = 173719
--select * from payment where paymentid = 173719
--select * from commission where refid = 173719

CREATE PROCEDURE [dbo].pts_Commission_Company_21a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @Sponsor3ID int, @PinnacleID int
DECLARE @PayTitle int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @Level int 
DECLARE @Amount money, @Code varchar(100), @MemberID int, @tmpReferralID int, @Ref varchar(100), @cnt int
DECLARE @MemberTitle int, @Price money
DECLARE @OwnerType int, @OwnerID int, @MerchantID int, @CommStatus int

SET @CompanyID = 21
SET @Now = GETDATE()
SET @Code = ''

SELECT @Code = Purpose, @Price = Amount, @OwnerType = OwnerType, @OwnerID = OwnerID
FROM Payment WHERE PaymentID = @PaymentID AND Status = 3 AND CommStatus = 1

IF @Code <> ''
BEGIN
	--Get Member Info
	IF @OwnerType = 4 SET @MemberID = @OwnerID

	--Get referring Member of Consumer 
	IF @OwnerType = 151
	BEGIN
		SELECT @MemberID = MemberID, @MerchantID = MerchantID FROM Consumer WHERE ConsumerID = @OwnerID
		IF @MerchantID > 0 SELECT @MemberID = MemberID FROM Merchant WHERE MerchantID = @MerchantID
	END

	SELECT @MemberTitle = Title, @Ref = LTRIM(STR(MemberID)) + ' ' + NameFirst + ' ' + NameLast, @ReferralID = ReferralID, @Sponsor3ID = Sponsor3ID
	FROM Member WHERE MemberID = @MemberID

	SET @tmpReferralID = @ReferralID

	-- Get the Bonus Volume for the payment
	SET @Amount = 0
	EXEC pts_Nexxus_PaymentBV @PaymentID, @Amount OUTPUT

	-- Update Payment Commission Status and date
	UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

	--	*************************************************
	--	Calculate Pinnacle System Fees
	--	*************************************************
	SET @Bonus = 0
	SET @Bonus = @Amount * .05
	IF @Bonus > 0
	BEGIN
		SET @CommType = 19
		SET @Desc = @Ref
	--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		SET @PinnacleID = 37701 
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END

	--	*************************************************
	--	Calculate Retail Profit for Customer Sales
	--  Affiliate is charged 5% processing fee of retail price
	--	*************************************************
	IF @MemberTitle = 1 AND @Code IN ('200','201','202','203','204','205')
	BEGIN
		SET @Bonus = 0
		IF @Amount = 2 AND @Price >= 9.95 SET @Bonus = 7.50
		IF @Amount = 10 AND @Price >= 24.95 SET @Bonus = 13.75
		IF @Amount = 25 AND @Price >= 79.95 SET @Bonus = 51
		IF @Amount = 50 AND @Price >= 99.95 SET @Bonus = 45
		
		IF @Bonus > 0
		BEGIN	
			SET @MemberID = @ReferralID
			SET @CommType = 10
			SET @Desc = @Ref 
	--		CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END
	END

	-- ***********************************************************************
	-- Calculate Team Bonuses
	-- ***********************************************************************
	IF @Code IN ('100','101','102','103','106','107','108','116','117','118','200','201','202','203','204','205')
	BEGIN
	--	Start with the member's sponsor (team upline)
	--	If customer sale, use enroller's sponsor (customer title = 1)
		IF @MemberTitle = 1
			SELECT @MemberID = ReferralID FROM Member WHERE MemberID = @ReferralID
		ELSE
			SET @MemberID = @ReferralID
		
	--	-- Set Bonus Type
		SET @CommType = 11
		
		SET @Level = 1
		WHILE @Level <= 9 AND @MemberID > 0
		BEGIN
			IF @Level = 1 SET @Bonus = @Amount * .10 ELSE SET @Bonus = @Amount * .03

	--		-- Get the Referrer's info
			SET @ReferralID = -1
			SELECT @ReferralID = ReferralID, @Qualify = Qualify, @PayTitle = Title2 FROM Member WHERE MemberID = @MemberID
	--		--Did we find the member
			IF @ReferralID >= 0
			BEGIN
				IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @MemberID

				IF @Qualify > 1 
				BEGIN
	--				-- Check if qualified for level based on title
					IF @Level = 1 AND @PayTitle < 3 SET @Qualify = 0
					IF @Level = 2 AND @PayTitle < 4 SET @Qualify = 0
					IF @Level = 3 AND @PayTitle < 5 SET @Qualify = 0
					IF @Level = 4 AND @PayTitle < 6 SET @Qualify = 0
					IF @Level = 5 AND @PayTitle < 8 SET @Qualify = 0
					IF @Level = 6 AND @PayTitle < 10 SET @Qualify = 0
					IF @Level = 7 AND @PayTitle < 12 SET @Qualify = 0
					IF @Level = 8 AND @PayTitle < 13 SET @Qualify = 0
					IF @Level = 9 AND @PayTitle < 14 SET @Qualify = 0

					IF @Qualify > 1 
					BEGIN
						SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
	--					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
						EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
						SET @Count = @Count + 1
						
	--					-- Calculate Matching Bonuses
						EXEC pts_Commission_Company_21c @PaymentID, @Now, @MemberID, @ReferralID, @Bonus, @Ref, @cnt OUTPUT
						SET @Count = @Count + @cnt

					END
	--				-- move to next level to process (dynamic compression)
					SET @Level = @Level + 1
				END 
	--			-- Set the memberID to get the next upline Referral
				SET @MemberID = @ReferralID
			END
			ELSE SET @MemberID = 0
		END
	END

	--	*****************************************************
	--	Calculate Binary Bonuses
	--	*****************************************************
	--	Start with the member's sponsor (binary upline)
	--	If customer sale, use enroller's binary sponsor (customer title = 1)
	SET @MemberID = @Sponsor3ID
	IF @MemberTitle = 1 SELECT @MemberID = Sponsor3ID FROM Member WHERE MemberID = @tmpReferralID
	SET @cnt = 0
	EXEC pts_Commission_Company_21b @MemberID, @PaymentID, @Ref, @cnt OUTPUT 
	SET @Count = @Count + @cnt

END

GO
