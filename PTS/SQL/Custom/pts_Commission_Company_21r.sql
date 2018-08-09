EXEC [dbo].pts_CheckProc 'pts_Commission_Company_21r'
GO
--DECLARE @Count int    EXEC pts_Commission_Company_21r 22, @Count OUTPUT    PRINT 'Bonuses: ' + cast(@Count as varchar(10))

CREATE PROCEDURE [dbo].pts_Commission_Company_21r
   @Payment2ID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @Now datetime, @ID int, @Bonus money, @Desc varchar(100), @PinnacleID int, @NXCPrice money 
DECLARE @MerchantID int, @ConsumerID int, @Fee money, @Amount money, @Ref varchar(100), @Coins bigint, @SellingMerchantID int
DECLARE @MemberID int, @Title int, @Status int, @CommType int, @Qualify int, @Level int, @ReferralID int, @PayTitle int, @RefID int, @Test int 
DECLARE @CountryID int, @Zip varchar(10), @SalesAreaID int, @ParentID int, @Ref2 varchar(100), @ZipName varchar(30), @LocalName varchar(40), @RegionName varchar(40)
DECLARE @Role nvarchar(15), @ReferRate money

--*** TEST MODE *******
SET @Test = 0
--*********************

SET @Count = 0
SET @CompanyID = 21
SET @Now = GETDATE()
SET @RefID = @Payment2ID * -1  -- negative to avoid conflict with commission reference to old paymentid

-- Get all the Payment2 information (approved and not commissioned) 
SELECT @MerchantID = co.MerchantID, @MemberID = co.MemberID, @ConsumerID = co.ReferID, @Fee = pa.Fee, @Ref = co.NameFirst + ' ' + co.NameLast, @SellingMerchantID = pa.MerchantID
FROM   Payment2 AS pa JOIN Consumer AS co ON pa.ConsumerID = co.ConsumerID 
WHERE  pa.Payment2ID = @Payment2ID AND pa.Status = 3 AND pa.CommStatus = 1

-- Update Payment2 Commission Status and date
IF @Test = 0 UPDATE Payment2 SET CommStatus = 2, CommDate = @Now WHERE Payment2ID = @Payment2ID

--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
SET @Bonus = ROUND(@Fee * .05, 2)
IF @Bonus > 0
BEGIN
	SET @CommType = 29
	SET @Desc = @Ref
	SET @PinnacleID = 37701 
--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
	IF @Test = 0 EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @RefID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
	IF @Test = 1 PRINT 'System: ' + CAST(@PinnacleID AS varchar(10)) + ' - ' + CAST(@Bonus AS varchar(10)) + ' - ' + @Desc
	SET @Count = @Count + 1
END

--	*****************************************************************
--	Calculate Referral Bonus reward points for the referring shopper
--	*****************************************************************
IF @ConsumerID > 0 
BEGIN
	SELECT @Status = Status FROM Consumer WHERE ConsumerID = @ConsumerID
	--check for active consumer
	IF @Status = 2
	BEGIN
		-- Get the price of the Nexxus coin
		EXEC pts_CoinPrice_GetPrice 2, 'USD', @NXCPrice OUTPUT
		-- Pay 10% referral bonus points
		SET @Amount = @Fee * .1
		-- Create note for reward
		SET @Desc = @Ref + ' ' + CAST(@Amount AS VARCHAR(20)) + ' / ' + CAST(@NXCPrice AS VARCHAR(20)) 
		-- Calculate the number of reward points
		SET @Amount = @Amount / @NXCPrice
		-- Convert to satoshi
		SET @Coins = @Amount * 100000000
		IF @Coins > 0
		BEGIN
			-- RewardID,MerchantID,ConsumerID,Payment2ID,AwardID,RewardDate,RewardType,Amount,Status,HoldDate,Reference,Note,UserID
			IF @Test = 0 EXEC pts_Reward_Add @ID, @MerchantID, @ConsumerID, @Payment2ID, 0, @Now, 1, @Coins, 3, 0, '', @Desc, 1
			IF @Test = 1 PRINT 'Shopper: ' + CAST(@ConsumerID AS varchar(10)) + ' - ' + CAST(@Coins AS varchar(10)) + ' - ' + @Desc
		END
	END
END

--	*****************************************************************
--	Calculate Referral Bonus for the referring merchant
--	*****************************************************************
IF @MerchantID > 0 
BEGIN
	SELECT @Status = Status, @ReferRate = ReferRate FROM Merchant WHERE MerchantID = @MerchantID
	--check that merchant is not cancelled or removed
	IF @Status NOT IN (4,5)
	BEGIN
		-- Pay 10% - 20% referral bonus to merchant
		IF @ReferRate < 10 OR @ReferRate > 20 SET @ReferRate = 10
		SET @ReferRate = @ReferRate / 100
		SET @Bonus = ROUND(@Fee * @ReferRate, 2)
		IF @Bonus > 0
		BEGIN	
			SET @CommType = 21
			SET @Desc = @Ref + ' (merchant #' + CAST(@SellingMerchantID AS VARCHAR(10)) + ')'
			--CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			IF @Test = 0 EXEC pts_Commission_Add @ID, @CompanyID, 150, @MerchantID, 0, @RefID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			IF @Test = 1 PRINT 'Merchant: ' + CAST(@MerchantID AS varchar(10)) + ' - ' + CAST(@Bonus AS varchar(10)) + ' - ' + @Desc
			SET @Count = @Count + 1
		END
	END
END

--	*****************************************************************
--	Calculate Sales Bonus for the referring affiliate
--	*****************************************************************
IF @MerchantID > 0 OR @MemberID > 0
BEGIN
	-- If a merchant, Get the affiliate that enrolled the merchant
	IF @MerchantID > 0 SELECT @MemberID = MemberID FROM Merchant WHERE MerchantID = @MerchantID
	IF @MemberID > 0
	BEGIN
		SELECT @Qualify = Qualify FROM Member WHERE MemberID = @MemberID
		--check that member is bonus qualified
		IF @Qualify > 1
		BEGIN
			-- Pay 20% if Rewards sales member otherwise pay 15%
			-- Check if the member is in the Rewards Sales system
			SET @ID = 0
			SELECT @ID = SalesMemberID FROM SalesMember WHERE MemberID = @MemberID
			IF @ID > 0
				SET @Bonus = ROUND(@Fee * .2, 2)
			ELSE
				SET @Bonus = ROUND(@Fee * .15, 2)

			IF @Bonus > 0
			BEGIN	
				SET @CommType = 22
				SET @Desc = @Ref + ' (merchant #' + CAST(@SellingMerchantID AS VARCHAR(10)) + ')'
				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				IF @Test = 0 EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @RefID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				IF @Test = 1 PRINT 'Affiliate: ' + CAST(@MemberID AS varchar(10)) + ' - ' + CAST(@Bonus AS varchar(10)) + ' - ' + @Desc
				SET @Count = @Count + 1
			END
		END
	END
END

-- ***********************************************************************
-- Calculate sales management Bonuses
-- ***********************************************************************
IF @MemberID > 0
BEGIN
	-- Start with the member's referrer
	SELECT @MemberID = ReferralID, @Ref2 = '#' + LTRIM(STR(MemberID)) + ' ' + NameFirst + ' ' + NameLast FROM Member WHERE MemberID = @MemberID

	-- Set Bonus Type
	SET @CommType = 23
	
	SET @Level = 1
	WHILE @Level <= 4 AND @MemberID > 0
	BEGIN
		-- 25%, 12%, 8%, 5%
		IF @Level = 1 SET @Bonus = ROUND(@FEE * .05, 2)
		IF @Level = 2 SET @Bonus = ROUND(@FEE * .024, 2)
		IF @Level = 3 SET @Bonus = ROUND(@FEE * .016, 2)
		IF @Level = 4 SET @Bonus = ROUND(@FEE * .01, 2)
		
--		-- Get the Referrer's info
		SET @ReferralID = -1
		SELECT @ReferralID = ReferralID, @Role = [Role] FROM Member WHERE MemberID = @MemberID
--		--Did we find the member
		IF @ReferralID >= 0
		BEGIN
			IF @Role IN ('2','3','4','5') 
			BEGIN
				SET @Qualify = 1
--				-- Check if qualified for level based on title
				IF @Level = 1 AND @Role < '2' SET @Qualify = 0
				IF @Level = 2 AND @Role < '3' SET @Qualify = 0
				IF @Level = 3 AND @Role < '4' SET @Qualify = 0
				IF @Level = 4 AND @Role < '5' SET @Qualify = 0

				IF @Qualify != 0 AND @Bonus > 0
				BEGIN
					SET @Desc = @Ref2 + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
					IF @Test = 0 EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @RefID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
					IF @Test = 1 PRINT 'Management: ' + CAST(@MemberID AS varchar(10)) + ' - ' + CAST(@Bonus AS varchar(10)) + ' - ' + @Desc
					SET @Count = @Count + 1
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

-- ***********************************************************************
-- Calculate sales support Bonuses
-- ***********************************************************************
-- Get the country and zip code of the selling merchant
SET @CountryID = 0
SET @Zip = ''
SELECT @CountryID = CountryID, @Zip = Zip FROM Merchant WHERE MerchantID = @SellingMerchantID
IF @CountryID > 0 AND @Zip <> ''
BEGIN
	-- Get the local sales area territory for the country and zip code
	SET @SalesAreaID = 0
	SELECT @SalesAreaID = SalesAreaID, @ZipName = ZipName FROM SalesZip WHERE CountryID = @CountryID AND ZipCode = @Zip
	IF @SalesAreaID > 0
	BEGIN
		SET @ParentID = 0
		SET @Bonus = ROUND(@Fee * .05, 2)
		IF @Bonus > 0
		BEGIN	
			SET @MemberID = 0
			SELECT @MemberID = MemberID, @ParentID = ParentID, @LocalName = SalesAreaName FROM SalesArea WHERE SalesAreaID = @SalesAreaID
			-- If we found the support member and it is not Nexxus
			IF @MemberID > 0 AND @MemberID <> 37702		
			BEGIN
				SET @CommType = 24
				SET @Desc = @Ref + ' (merchant #' + CAST(@SellingMerchantID AS VARCHAR(10)) + ' ' + @ZipName + ')'
				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				IF @Test = 0 EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @RefID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				IF @Test = 1 PRINT 'Local Support: ' + CAST(@MemberID AS varchar(10)) + ' - ' + CAST(@Bonus AS varchar(10)) + ' - ' + @Desc
				SET @Count = @Count + 1
			END
		END
		-- Get the regional sales area for the local sales area
		IF @ParentID > 0
		BEGIN
			SET @Bonus = ROUND(@Fee * .01, 2)
			IF @Bonus > 0
			BEGIN	
				SET @MemberID = 0
				SELECT @MemberID = MemberID, @ParentID = ParentID, @RegionName = LEFT(SalesAreaName,2) FROM SalesArea WHERE SalesAreaID = @ParentID
				-- If we found the support member and it is not Nexxus
				IF @MemberID > 0 AND @MemberID <> 37702		
				BEGIN
					SET @CommType = 25
					SET @Desc = @Ref + ' (merchant #' + CAST(@SellingMerchantID AS VARCHAR(10)) + ' ' + @LocalName + ')'
					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
					IF @Test = 0 EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @RefID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
					IF @Test = 1 PRINT 'Regional Support: ' + CAST(@MemberID AS varchar(10)) + ' - ' + CAST(@Bonus AS varchar(10)) + ' - ' + @Desc
					SET @Count = @Count + 1
				END
			END
			ELSE SET @ParentID = 0

			-- Get the national sales area for the regional sales area
			IF @ParentID > 0
			BEGIN
				SET @Bonus = ROUND(@Fee * .01, 2)
				IF @Bonus > 0
				BEGIN	
					SET @MemberID = 0
					SELECT @MemberID = MemberID FROM SalesArea WHERE SalesAreaID = @ParentID
					-- If we found the support member and it is not Nexxus
					IF @MemberID > 0 AND @MemberID <> 37702		
					BEGIN
						SET @CommType = 26
						SET @Desc = @Ref + ' (merchant #' + CAST(@SellingMerchantID AS VARCHAR(10)) + ' ' + @RegionName + ')'
						-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
						IF @Test = 0 EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @RefID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
						IF @Test = 1 PRINT 'National Support: ' + CAST(@MemberID AS varchar(10)) + ' - ' + CAST(@Bonus AS varchar(10)) + ' - ' + @Desc
						SET @Count = @Count + 1
					END
				END
			END
		END
	END
END

GO
