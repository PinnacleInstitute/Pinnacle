EXEC [dbo].pts_CheckProc 'pts_Commission_Company_14a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_14a 33543, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_14a
   @PaymentID int ,
   @Count int OUTPUT 
AS

-- *************************************************************************
-- Lost Bonuses: NOT Bonus Qualified for Retail, Fast Start, Matrix, Coded
-- *************************************************************************

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @NextReferralID int, @SponsorID int, @Sponsor3ID int, @Level int, @Level2 int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @MemberQualify int, @Qualify int, @Retail money 
DECLARE @tmpMemberID int, @tmpReferralID int, @FastStart int, @cnt int, @Price money, @BV money
DECLARE @CommPlan int, @Amount money, @Code varchar(10), @MemberID int, @Ref varchar(100), @Options2 varchar(100), @tmpOptions2 varchar(100)
DECLARE @EnrollDate datetime, @PinnacleID int, @tmpCode varchar(100), @Pos int
DECLARE @QVLeft money, @QVRight money

SET @CompanyID = 14
SET @Count = 0
SET @Now = GETDATE()

DECLARE SalesItem_cursor CURSOR LOCAL STATIC FOR 
SELECT pr.CommPlan, si.Quantity * pr.BV, si.Quantity * pr.OriginalPrice, pr.Code, me.MemberID, LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, me.Options2, me.ReferralID, me.SponsorID , me.Sponsor3ID 
FROM   SalesItem AS si
JOIN   SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
JOIN   Product AS pr ON si.ProductID = pr.ProductID
JOIN   Member AS me ON so.MemberID = me.MemberID 
JOIN   Payment AS pa ON pa.OwnerType = 52 AND so.SalesOrderID = pa.OwnerID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1
--AND	   pr.BV > 0 
AND so.Status <= 3 AND si.Status <= 3

OPEN SalesItem_cursor
FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Retail, @Code, @MemberID, @Ref, @Options2, @ReferralID, @SponsorID, @Sponsor3ID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @tmpMemberID = @MemberID
	SET @tmpReferralID = @ReferralID
	SET @FastStart = 0

--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
	SET @Bonus = 0
	IF @Code = '102' SET @Bonus = 2  -- New Wholesale Buyer
	IF @Code = '103' SET @Bonus = 2  -- New Affilate
--	IF @Code = '104' SET @Bonus = 1  -- New Silver
--	IF @Code = '105' SET @Bonus = 2  -- New Gold
--	IF @Code = '106' SET @Bonus = 3  -- New Diamond #1
--	IF @Code = '107' SET @Bonus = 3  -- New Diamond #2
--	IF @Code = '108' SET @Bonus = 3  -- New Diamond #3
--	IF @Code = '109' SET @Bonus = 3  -- Diamond Truck
--	IF @Code = '110' SET @Bonus = 3  -- Diamond Auto
--	IF @Code = '125' SET @Bonus = 3  -- Diamond Sample
--	IF @Code = '131' SET @Bonus = 2  -- Gold Upgrade to Diamond
	IF @Code = '111' SET @Bonus = 1  -- Autoship Customer
	IF @Code = '112' SET @Bonus = 1  -- Autoship Wholesale Buyer
	IF @Code = '113' SET @Bonus = 1  -- Autoship Founder
	IF @Code = '114' SET @Bonus = 3  -- Autoship Founder QTR
	IF @Code = '115' SET @Bonus = 1  -- Autoship 3 Diamond
	IF @Code = '116' SET @Bonus = 3  -- Autoship 3 Diamond QTR
	IF @Code = '117' SET @Bonus = 2  -- Autoship Blue Diamond
	IF @Code = '118' SET @Bonus = 6  -- Autoship Blue Diamond QTR
	IF @Code = '119' SET @Bonus = 2  -- Autoship Presidential
	IF @Code = '120' SET @Bonus = 6  -- Autoship Presidential QTR
	IF @Code = '121' SET @Bonus = 6  -- Autoship Trucker Qtr
		
	IF @Bonus > 0
	BEGIN
--		SET @PinnacleID = 10481
		SET @PinnacleID = 10819
		SET @CommType = 10
		SET @Desc = @Ref
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END

--	*************************************************
--	Calculate Retail Commissions
--	*************************************************
	IF @Retail > 0
	BEGIN
		SET @Bonus = @Retail

		SET @Qualify = 0
--		Look for the next qualified upline referrer to get this bonus		
		WHILE @Qualify <= 1 AND @ReferralID > 0
		BEGIN 
			SET @NextReferralID = -1
			SELECT @NextReferralID = ReferralID, @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
--			Check if we found the referrer
			IF @NextReferralID >= 0
			BEGIN
				IF @Qualify <= 1
				BEGIN
				 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @ReferralID
				 SET @ReferralID = @NextReferralID
				END 
			END
			ELSE SET @ReferralID = 0
		END

		IF @Qualify > 1 
		BEGIN
			SET @CommType = 1
			SET @Desc = @Ref
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END
	END

--	*************************************************
--	Calculate Fast Start Bonus
--	*************************************************
	SET @Bonus = 0
	IF @Code = '104' SET @Bonus = 7.5   -- New Silver
	IF @Code = '105' SET @Bonus = 25  -- New Gold
	IF @Code = '106' SET @Bonus = 70  -- New Diamond #1
	IF @Code = '107' SET @Bonus = 70  -- New Diamond #2
	IF @Code = '108' SET @Bonus = 70  -- New Diamond #3
	IF @Code = '109' SET @Bonus = 75  -- Diamond Truck Pack
	IF @Code = '110' SET @Bonus = 75  -- Diamond Auto Pack
	IF @Code = '125' SET @Bonus = 75  -- Diamond Sample Pack
	IF @Code = '101' SET @Bonus = 75  -- Diamond OPTMOTOR
	IF @Code = '100' SET @Bonus = 100 -- Diamond MAX-MPG
	IF @Code = '131' SET @Bonus = 50  -- Upgrade Diamond

	IF @Bonus > 0
	BEGIN
		SET @ReferralID = @tmpReferralID
		SET @Qualify = 0
--		Look for the next qualified upline referrer to get this bonus		
		WHILE @Qualify <= 1 AND @ReferralID > 0
		BEGIN 
			SET @NextReferralID = -1
			SELECT @NextReferralID = ReferralID, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @ReferralID
--			Check if we found the referrer
			IF @NextReferralID >= 0
			BEGIN
--				Check if the Referrer is at least a Silver
				IF @Title < 3 SET @Qualify = 0
				IF @Qualify <= 1
				BEGIN
				 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @ReferralID
				 SET @ReferralID = @NextReferralID
				END 
			END
			ELSE SET @ReferralID = 0
		END
		
		IF @Qualify > 1
		BEGIN
			SET @CommType = 2
			SET @Desc = @Ref
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END
		
--		************************************************************
--		Calculate Coded Bonuses for new enrollment/upgrade packages
--		************************************************************
		SET @cnt = 0
		EXEC pts_Commission_Company_14c @MemberID, @PaymentID, @Ref, @Code, @cnt OUTPUT
		SET @Count = @Count + @cnt
	END
	
--	*****************************************************
--	Calculate Binary Bonuses - Walk up the entire upline
--	*****************************************************
	SET @cnt = 0
	EXEC pts_Commission_Company_14b @Sponsor3ID, @PaymentID, @Ref, @cnt OUTPUT 
	SET @Count = @Count + @cnt

--	*****************************************************
--	Calculate Matrix Bonuses (Only Autoship Products
--	*****************************************************
	EXEC pts_Legacy_ValidAutoShip @Code, @tmpCode OUTPUT
--	SET @tmpCode = ''
	IF @tmpCode != ''
	BEGIN
--		-- Start with the member's sponsor (matrix upline)
		SET @MemberID = @SponsorID

--		-- Set Matrix Bonus Type
		SET @CommType = 6
		
		SET @Level = 1
		WHILE @Level <= 5 AND @MemberID > 0
		BEGIN
--			-- Get the Referrer's info
			SET @SponsorID = -1
			SELECT @SponsorID = SponsorID, @MemberQualify = Qualify, @Title = Title FROM Member WHERE MemberID = @MemberID

--			--Override qualification for Tim's accounts
			IF @MemberID IN ( 10287, 10289, 10297 ) SET @MemberQualify = 2
			
--			--Did we find the member
			IF @SponsorID >= 0
			BEGIN
				IF @Level = 1 SET @Bonus = ROUND(@Amount * .5, 2)
				IF @Level IN (2,3,4) SET @Bonus = ROUND(@Amount * .1, 2)
				IF @Level = 5 SET @Bonus = ROUND(@Amount * .2, 2)

				SET @Qualify = 2
				
--				-- Check for valid Business Builder Purchaser				
				IF @Code = '122' OR @Code = '123'
				BEGIN
					SELECT @tmpOptions2 = Options2 FROM Member WHERE MemberID = @MemberID	
					IF @Code = '122' AND CHARINDEX('122', @Options2) = 0 AND CHARINDEX('123', @Options2) = 0 SET @Qualify = 0
					IF @Code = '123' AND CHARINDEX('123', @Options2) = 0 SET @Qualify = 0
				END

				IF @Qualify > 1
				BEGIN
--					-- IF Member NOT Bonus Qualified, Accumulate Lost Bonus
					IF @MemberQualify <= 1	UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @MemberID
					
					IF @MemberQualify > 1
					BEGIN				
--						Get the number of active personal referrals that are al least an affiliate title (2)
						SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Title >= 2 

						IF @Level = 1 AND ( @Title < 3 OR @cnt < 1 ) SET @Qualify = 0
						IF @Level = 2 AND ( @Title < 5 OR @cnt < 1 ) SET @Qualify = 0
						IF @Level = 3 AND ( @Title < 6 OR @cnt < 2 ) SET @Qualify = 0
						IF @Level = 4 AND ( @Title < 7 OR @cnt < 4 ) SET @Qualify = 0
						IF @Level = 5 AND ( @Title < 8 OR @cnt < 6 ) SET @Qualify = 0
					
--						--Override qualification for Tim's accounts
						IF @MemberID IN ( 10287, 10289, 10297 ) SET @Qualify = 2

						IF @Qualify > 1 
						BEGIN
							SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--							-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
							EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
							SET @Count = @Count + 1
							
--							-- move to next level to process (dynamic compression)
							SET @Level = @Level + 1
						END
					END
				END 
--				-- Set the memberID to get the next upline Referral
				SET @MemberID = @SponsorID
			END
			ELSE SET @MemberID = 0
		END
	
	END
		
	FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Retail, @Code, @MemberID, @Ref, @Options2, @ReferralID, @SponsorID, @Sponsor3ID
END
CLOSE SalesItem_cursor
DEALLOCATE SalesItem_cursor


-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
