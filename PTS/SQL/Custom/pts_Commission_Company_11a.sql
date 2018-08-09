EXEC [dbo].pts_CheckProc 'pts_Commission_Company_11a'
GO
--update payment set commstatus = 1, commdate = 0 where paymentid = 25453
--DECLARE @Count int EXEC pts_Commission_Company_11a 25453, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_11a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @Level int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @RapidO int, @Rate money, @tmpReferralID int, @GloryCard int
DECLARE @CommPlan int, @Amount money, @Code varchar(10), @MemberID int, @Ref varchar(100), @Cnt int, @CardCredit int
DECLARE @EnrollDate datetime, @Credit int, @RetailProfit money, @MonthEnd datetime

SET @CompanyID = 11
SET @Now = GETDATE()
SET @MonthEnd = CAST(CAST(Month(@Now) AS varchar(2)) + '/1/' + CAST(Year(@Now) AS varchar(4)) AS datetime)
SET @MonthEnd = DATEADD(D,-1,@MonthEnd)

DECLARE SalesItem_cursor CURSOR LOCAL STATIC FOR 
SELECT pr.CommPlan, si.Quantity * pr.BV, pr.Code, me.MemberID, LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, si.Quantity * pr.OriginalPrice
FROM   SalesItem AS si
JOIN   SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
JOIN   Product AS pr ON si.ProductID = pr.ProductID
JOIN   Member AS me ON so.MemberID = me.MemberID 
JOIN   Payment AS pa ON pa.OwnerType = 52 AND so.SalesOrderID = pa.OwnerID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1
--AND	   pr.BV > 0 
AND so.Status <= 3 AND si.Status <= 3

OPEN SalesItem_cursor
FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Code, @MemberID, @Ref, @RetailProfit
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @RapidO = 0
	SET @GloryCard = 0
	SET @Credit = 0
	SET @CardCredit = 0
	IF @Code = '101' OR @Code = '102' OR @Code = '103' OR @Code = '104' SET @RapidO = 1
	IF @Code = '201' OR @Code = '202' OR @Code = '203' SET @GloryCard = 1

	SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID

	SET @Bonus = 0
	SET @Qualify = 0

--	*************************************************
--	Retail Commission
--	*************************************************
	IF @RetailProfit > 0
	BEGIN
		SELECT @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
		IF @Qualify > 1
		BEGIN		
			SET @CommType = 1
			SET @Bonus = @RetailProfit
			SET @Desc = @Ref + ' (' + @Code + ')'
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END
	END

--	*************************************************
--	Glory Commission
--	*************************************************
	IF @GloryCard = 1
	BEGIN
		SELECT @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
		
		IF @Qualify > 1
		BEGIN
			SET @CommType = 5
			IF @Code = '201' SET @Bonus = 30
			IF @Code = '202' SET @Bonus = 35
			IF @Code = '203' SET @Bonus = 100
			
--			-- Check if the Referrer has any Credits for Single Glory Cards			
			SELECT @Credit = Amount FROM Payment WHERE OwnerType = 4 AND OwnerID = @ReferralID AND PayType = 91
			IF @Code = '201' AND @Credit >= 2 SET @CardCredit = 2
			IF @Code = '202' AND @Credit >= 2 SET @CardCredit = 2
			IF @Code = '203' AND @Credit >= 6 SET @CardCredit = 6

			IF @CardCredit > 0
			BEGIN
				-- Retail Commission (93% of retail)
				SET @CommType = 1
				IF @Code = '201' SET @Bonus = 99.51
				IF @Code = '202' SET @Bonus = 118.11
				IF @Code = '203' SET @Bonus = 304.11
				-- Decrement Referrer's Glory Card Credits
				UPDATE Payment SET Amount = Amount - @CardCredit, Credit = Credit + @CardCredit WHERE OwnerType = 4 AND OwnerID = @ReferralID AND PayType = 91
			END	

			SET @Desc = @Ref
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END
	END

--	*************************************************
--	RapidO Bonuses on Business Starter Kits
--	*************************************************
	IF @RapidO = 1
	BEGIN
		SELECT @Title = Title, @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
--		Must be at least a Junior
		IF @Title < 3 SET @Qualify = 0
		
		IF @Qualify > 1
		BEGIN
			SET @Bonus = 0
			IF @Code = '101' SET @Bonus = 100
			IF @Code = '102' SET @Bonus = 165
			IF @Code = '103' SET @Bonus = 500
			IF @Bonus > 0
			BEGIN
				SET @CommType = 2
				SET @Desc = @Ref
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1

--				Calculate Matching Bonuses
				SET @Cnt = 0
				EXEC pts_Commission_Company_11b @PaymentID, @ReferralID, @Bonus, @Ref, @MonthEnd, @Cnt OUTPUT 
				IF @Cnt > 0 SET @Count = @Count + @Cnt
			END
		END
	END

--	*******************************************************************
--	Monthly Bonuses (Don't pay this for RapidO and Glory Card Credits)
--  Post date these bonuses to month end
--	*******************************************************************
	IF @RapidO = 0 AND @CardCredit = 0
	BEGIN
--		-- Start with the member's referrer
		SET @MemberID = @ReferralID
		SET @Level = 1
		WHILE @Level <= 5 AND @MemberID > 0
		BEGIN
--			-- Get the Referrer's info
			SET @ReferralID = -1
			SELECT @ReferralID = ReferralID, @Title = Title, @Qualify = Qualify FROM Member WHERE MemberID = @MemberID

--			--Did we find the member
			IF @ReferralID >= 0
			BEGIN
--				Must be at least a Junior
				IF @Title < 3 SET @Qualify = 0
				
--				-- Is this member qualified to receive bonuses, otherwise skip (dynamic compression)
				IF @Qualify > 1
				BEGIN
--					-- Are they qualified for the level
					IF @Level = 7 AND @Title < 4 SET @Qualify = 0
					IF @Level = 8 AND @Title < 5 SET @Qualify = 0
					IF @Level = 9 AND @Title < 6 SET @Qualify = 0
					IF @Level = 10 AND @Title < 7 SET @Qualify = 0

					IF @Qualify > 1
					BEGIN
						SET @Rate = 0
--						Junior					
						IF @Title = 3
						BEGIN
							IF @Level = 1 SET @Rate = .2
							IF @Level > 1 SET @Rate = .01
						END
--						Partner					
						IF @Title = 4
						BEGIN
							IF @Level = 1 SET @Rate = .2
							IF @Level = 2 SET @Rate = .05
							IF @Level > 2 SET @Rate = .01
						END
--						Senior					
						IF @Title = 5
						BEGIN
							IF @Level = 1 SET @Rate = .25
							IF @Level = 2 SET @Rate = .05
							IF @Level > 2 SET @Rate = .01
						END
--						Executive					
						IF @Title = 6
						BEGIN
							IF @Level = 1 SET @Rate = .25
							IF @Level = 2 SET @Rate = .07
							IF @Level = 3 SET @Rate = .03
							IF @Level > 3 SET @Rate = .01
						END
--						Diamond					
						IF @Title = 7
						BEGIN
							IF @Level = 1 SET @Rate = .25
							IF @Level = 2 SET @Rate = .10
							IF @Level = 3 SET @Rate = .05
							IF @Level = 4 SET @Rate = .03
							IF @Level > 4 SET @Rate = .01
						END
					
						IF @Rate > 0
						BEGIN					
							SET @CommType = 3
							SET @Bonus = ROUND(@Amount * @Rate, 2)
							SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--							-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
							EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @MonthEnd, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
							SET @Count = @Count + 1

--							Calculate Matching Bonuses
							SET @Cnt = 0
							EXEC pts_Commission_Company_11b @PaymentID, @MemberID, @Bonus, @Ref, @MonthEnd, @Cnt OUTPUT 
							IF @Cnt > 0 SET @Count = @Count + @Cnt

						END	
					END	
--					-- move to next level to process (dynamic compression)
					SET @Level = @Level + 1
				END
			END
--			-- Set the memberID to get the next upline Sponsor2 for the matching bonus
			SET @MemberID = @ReferralID
		END		
	END

	FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Code, @MemberID, @Ref, @RetailProfit
END
CLOSE SalesItem_cursor
DEALLOCATE SalesItem_cursor

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
