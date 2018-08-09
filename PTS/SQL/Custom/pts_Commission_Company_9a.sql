EXEC [dbo].pts_CheckProc 'pts_Commission_Company_9a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_9a 24601, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_9a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @Sponsor2ID int, @Sponsor3ID int, @Level int, @Level2 int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @Retail money 
DECLARE @tmpMemberID int, @FastStart int, @cnt int, @Price money, @BV money
DECLARE @CommPlan int, @Amount money, @Code varchar(10), @MemberID int, @Ref varchar(100), @Options2 varchar(100), @tmpOptions2 varchar(100)
DECLARE @EnrollDate datetime, @PinnacleID int
DECLARE @QVLeft money, @QVRight money

SET @CompanyID = 9
SET @Now = GETDATE()

DECLARE SalesItem_cursor CURSOR LOCAL STATIC FOR 
SELECT pr.CommPlan, si.Quantity * pr.BV, si.Quantity * pr.OriginalPrice, pr.Code, me.MemberID, LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, me.Options2
FROM   SalesItem AS si
JOIN   SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
JOIN   Product AS pr ON si.ProductID = pr.ProductID
JOIN   Member AS me ON so.MemberID = me.MemberID 
JOIN   Payment AS pa ON pa.OwnerType = 52 AND so.SalesOrderID = pa.OwnerID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1
--AND	   pr.BV > 0 
AND so.Status <= 3 AND si.Status <= 3

OPEN SalesItem_cursor
FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Retail, @Code, @MemberID, @Ref, @Options2
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @tmpMemberID = @MemberID
	SET @FastStart = 0

--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
	IF @Code = '101' OR @Code = '102' OR @Code = '201' OR @Code = '115' OR @Code = '116' OR @Code = '303'
	BEGIN
	--	Pay Pinnacle System Fees 		
		SET @PinnacleID = 7164
		SET @CommType = 10
		IF @Code = '303' SET @Bonus = 1  -- Wholesale Buyer
		IF @Code = '115' SET @Bonus = 3  -- Diamond Pak
		IF @Code = '116' SET @Bonus = 2  -- Gold Pak
		IF @Code = '101' OR @Code = '102' SET @Bonus = 2  -- Green Fuel Tabs Single / Double Pak
		IF @Code = '201' SET @Bonus = 6  -- 6 mo. Wealth Builder
		SET @Desc = @Ref
	--	-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END		

--	*************************************************
--	Calculate Retail Commissions
--	*************************************************
	IF @Retail > 0
	BEGIN
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		SET @Qualify = 0 
		SET @tmpOptions2 = ''
		SELECT @Qualify = Qualify, @tmpOptions2 = Options2 FROM Member WHERE MemberID = @ReferralID
--		Check if the Referrer is on the Wholesale, Gold or Diamond Plan
		IF CHARINDEX('303', @tmpOptions2) = 0 AND CHARINDEX('116', @tmpOptions2) = 0 SET @Qualify = 0

		IF @Qualify > 1
		BEGIN
			SET @Bonus = @Retail
			SET @CommType = 11
			SET @Desc = @Ref
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END
	END

--	Check if this Member is on the Binary Plan 
	IF CHARINDEX('B', @Options2) > 0
	BEGIN
--		*************************************************
--		Calculate Binary Bonuses
--		*************************************************
		SELECT @ReferralID = ReferralID, @Sponsor3ID = Sponsor3ID FROM Member WHERE MemberID = @MemberID
		SET @Qualify = 0

--		*************************************************
--		Calculate Binary Fast Start Bonus
--		*************************************************
		IF @Code = '115'
		BEGIN
			SELECT @Price = Price, @Qualify = Qualify, @Options2 = Options2 FROM Member WHERE MemberID = @ReferralID
--			Check if the Referrer is also on the Diamond Plan
			IF CHARINDEX('115', @Options2) = 0 SET @Qualify = 0

			IF @Qualify > 1
			BEGIN
				SET @Bonus = 90
--				SET @Bonus = 100
				SET @CommType = 6
				SET @Desc = @Ref
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
			END
		END
--		*****************************************************
--		Calculate Binary Bonuses - Walk up the entire upline
--		*****************************************************
		SET @cnt = 0
		EXEC pts_Commission_Company_9b @Sponsor3ID, @PaymentID, @Ref, @cnt OUTPUT 
		SET @Count = @Count + @cnt
		
--		*****************************************************
--		Calculate Coded Bonuses for new Diamonds
--		*****************************************************
		IF @Code = '115'
		BEGIN
			SET @cnt = 0
			EXEC pts_Commission_Company_9c @MemberID, @PaymentID, @Ref, @cnt OUTPUT
			SET @Count = @Count + @cnt
		END
	END
	ELSE
	BEGIN
--		*************************************************
--		Calculate Fast Start and Unilevel 7 Bonuses
--		*************************************************
		IF @CommPlan = 1
		BEGIN
--			If this is a Team Bonus
			IF @Code = '101' OR @Code = '102'
			BEGIN
--				Check if its the first payment (FastStart)
				SELECT @cnt = COUNT(SalesOrderID) FROM SalesOrder Where MemberID = @MemberID
				If @cnt = 1 SET @FastStart = 1
				If @FastStart = 1
				BEGIN
--					Check if this is an existing member exported into the new system before 2/27/13 (no Fast Start)
					SELECT @EnrollDate = EnrollDate FROM Member Where MemberID = @MemberID
					If @EnrollDate < '2/27/13' SET @FastStart = 0
				END
			END

--			Start with the member's referrer and coded upline
			SELECT @ReferralID = ReferralID, @Sponsor2ID = Sponsor2ID FROM Member WHERE MemberID = @MemberID

--			Calculate FastStart Bonus
			IF @FastStart = 1
			BEGIN
				SELECT @Price = Price, @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
				IF @Qualify > 1
				BEGIN
					SET @Bonus = 0
--					Order Single Pack
					IF @Code = '101' SET @Bonus = 10
--					Order Double Pack and Referrer ordered Single Pak
					IF @Code = '102' AND @Price < 25 SET @Bonus = 20
--					Order Double Pack and Referrer ordered Single Pak
					IF @Code = '102' AND @Price > 25 SET @Bonus = 30

					IF @Bonus > 0
					BEGIN	
						SET @CommType = 1
						SET @Desc = @Ref
--						-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
						EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
						SET @Count = @Count + 1
					END
				END
			END

--			Calculate Team Bonuses
			IF @FastStart = 0
			BEGIN
--				-- Start with the member's referrer
				SET @MemberID = @ReferralID
				SET @Level = 1
				WHILE @Level <= 7 AND @MemberID > 0
				BEGIN
--					-- Get the Referrer's info
					SET @ReferralID = -1
					SELECT @ReferralID = ReferralID, @Qualify = Qualify FROM Member WHERE MemberID = @MemberID

--					-- Get their number of referred Affiliates
					SELECT @BV = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Title > 0 AND Status >= 1 AND Status <= 4

--					--Did we find the member
					IF @ReferralID >= 0
					BEGIN
--						-- Are they qualified for the level
						IF @Level = 5 AND @BV < 2 SET @Qualify = 0
						IF @Level = 6 AND @BV < 3 SET @Qualify = 0
						IF @Level = 7 AND @BV < 4 SET @Qualify = 0

--						-- Is this member qualified to receive bonuses, otherwise skip (dynamic compression)
						IF @Qualify > 1
						BEGIN
							SET @Bonus = 0
							IF @Level = 1 SET @Bonus = ROUND(@Amount * .30, 2)
							IF @Level >= 2 AND @Level <= 6 SET @Bonus = ROUND(@Amount * .10, 2)
							IF @Level = 7 SET @Bonus = ROUND(@Amount * .20, 2)

							IF @Bonus > 0
							BEGIN	
								SET @CommType = 2
								SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--								-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
								EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
								SET @Count = @Count + 1
							END
--							-- move to next level to process (dynamic compression)
							SET @Level = @Level + 1
						END 
--						-- Set the memberID to get the next upline Referral
						SET @MemberID = @ReferralID
					END
					ELSE SET @MemberID = 0
				END
			END
		END

--		*************************************************
--		Calculate Coded 246 Bonuses
--		*************************************************
		IF @CommPlan = 2
		BEGIN
--			*************************************************
--			Calculate Leadership Bonuses
--			*************************************************
			SET @MemberID = @tmpMemberID
			SELECT @MemberID = Sponsor2ID FROM Member WHERE MemberID = @MemberID
			SET @Qualify = 0
			
--			Walk upline looking for the first qualified Affiliate
			WHILE @MemberID > 0 AND @Qualify = 0
			BEGIN
--				-- Get the Sponsor2ID's info
				SET @Sponsor2ID = -1
				SELECT @Sponsor2ID = Sponsor2ID, @Qualify = Qualify, @Options2 = Options2 FROM Member WHERE MemberID = @MemberID
				IF @Sponsor2ID >= 0
				BEGIN
					IF CHARINDEX('201', @Options2) = 0 SET @Qualify = 0
					IF @Qualify <= 1 SET @MemberID = @Sponsor2ID
				END
				ELSE SET @MemberID = 0
			END						

			IF @MemberID > 0 AND @Qualify > 1
			BEGIN
				SET @CommType = 3
				SET @Bonus = @Amount
				SET @Desc = @Ref
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1

--				*************************************************
--				Calculate Matching Bonuses and Ambassador Bonus
--				*************************************************
--				-- Start with the member's coded upline
				SET @MemberID = @Sponsor2ID
				SET @Level = 1
				WHILE @Level <= 7 AND @MemberID > 0
				BEGIN
--					-- Get the Referrer's info
					SET @Sponsor2ID = -1
					SELECT @Sponsor2ID = Sponsor2ID, @Qualify = Qualify, @Options2 = Options2 FROM Member WHERE MemberID = @MemberID

--					--Did we find the member
					IF @Sponsor2ID >= 0
					BEGIN
--						-- Get their number of referred Affiliates
						SELECT @BV = COUNT(*) FROM Member 
						WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Options2 like '%201%'

--						-- Are they qualified for the level
						IF CHARINDEX('201', @Options2) = 0 SET @Qualify = 0
						IF @Level = 1 AND @BV < 2 SET @Qualify = 0
						IF @Level = 2 AND @BV < 4 SET @Qualify = 0
						IF @Level = 3 AND @BV < 6 SET @Qualify = 0
						IF @Level = 4 AND @BV < 7 SET @Qualify = 0
						IF @Level = 5 AND @BV < 8 SET @Qualify = 0
						IF @Level = 6 AND @BV < 9 SET @Qualify = 0
						IF @Level = 7 AND @BV < 10 SET @Qualify = 0

--						-- If this member is qualified to receive bonuses, otherwise skip (no dynamic compression)
						IF @Qualify > 1
						BEGIN
							SET @Bonus = 0
							IF @Level >= 1 AND @Level <= 3 SET @Bonus = ROUND(@Amount * .20, 2)
							IF @Level >= 4 AND @Level <= 7 SET @Bonus = ROUND(@Amount * .10, 2)

							IF @Bonus > 0
							BEGIN	
								SET @CommType = 4
								SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--								-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
								EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
								SET @Count = @Count + 1
								
--								****************************
--								Calculate Ambassador Bonus
--								****************************
								SELECT @MemberID = @ReferralID FROM Member WHERE MemberID = @MemberID
								SET @cnt = 1
								WHILE @MemberID > 0
								BEGIN
--									-- Get the referrer's info
									SET @ReferralID = -1
									SELECT @ReferralID = ReferralID, @Title = Title, @Qualify = Qualify FROM Member WHERE MemberID = @MemberID

--									--Did we find the member
									IF @ReferralID >= 0 
									BEGIN
--										--Are they an Ambassador
										IF @Title = 9 
										BEGIN
--											-- Is this Ambassador qualified to receive bonuses
											IF @Qualify > 1
											BEGIN
												SET @CommType = 5
												SET @Bonus = ROUND(@Amount * .02, 2)
												SET @Desc = @Ref + ' (' + CAST( @cnt AS VARCHAR(2) ) + ')'
--												-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
												EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
												SET @Count = @Count + 1
											END 
--											-- stop looking for the upline ambassador							
											SET @MemberID = 0
										END 
										SET @cnt = @cnt + 1
									END
									ELSE SET @MemberID = 0
								END
--								****************************
								
							END
						END 
--						-- Set the memberID to get the next upline Sponsor2 for the matching bonus
						SET @MemberID = @Sponsor2ID
--						-- move to next level to process (no dynamic compression)
						SET @Level = @Level + 1
					END
					ELSE SET @MemberID = 0
				END
			END
		END
	END

	FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Retail, @Code, @MemberID, @Ref, @Options2
END
CLOSE SalesItem_cursor
DEALLOCATE SalesItem_cursor


-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
