EXEC [dbo].pts_CheckProc 'pts_Commission_Company_13a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_13a 28998, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_13a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @SponsorID int, @Level int, @Level2 int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @Retail money 
DECLARE @tmpMemberID int, @FastStart int, @cnt int, @Price money, @BV money
DECLARE @CommPlan int, @Amount money, @Code varchar(10), @MemberID int, @Ref varchar(100), @Options2 varchar(100), @tmpOptions2 varchar(100)
DECLARE @EnrollDate datetime, @PinnacleID int
DECLARE @QVLeft money, @QVRight money

SET @CompanyID = 13
SET @Now = GETDATE()

DECLARE SalesItem_cursor CURSOR LOCAL STATIC FOR 
SELECT pr.CommPlan, si.Quantity * pr.BV, si.Quantity * pr.OriginalPrice, pr.Code, me.MemberID, LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, me.ReferralID
FROM   SalesItem AS si
JOIN   SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
JOIN   Product AS pr ON si.ProductID = pr.ProductID
JOIN   Member AS me ON so.MemberID = me.MemberID 
JOIN   Payment AS pa ON pa.OwnerType = 52 AND so.SalesOrderID = pa.OwnerID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1
--AND	   pr.BV > 0 
AND so.Status <= 3 AND si.Status <= 3

OPEN SalesItem_cursor
FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Retail, @Code, @MemberID, @Ref, @ReferralID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @tmpMemberID = @MemberID

--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
	IF CHARINDEX(@Code, '101,102,103,104,105,106,107,108,109,110,111,224,225,226,227,228,229,221,334,335,336,337,338,339,331') > 0 
	BEGIN
	--	Pay Pinnacle System Fees 		
		SET @PinnacleID = 10121
		SET @CommType = 10
		SET @Bonus = 2
		IF CHARINDEX(@Code, '224,225,226,227,228,229,221') > 0  SET @Bonus = 4
		IF CHARINDEX(@Code, '334,335,336,337,338,339,331') > 0  SET @Bonus = 6
		
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
		SET @Qualify = 0
		SELECT @Level = Level, @Qualify = Qualify FROM Member WHERE MemberID = @MemberID
--		-- If this is a retail customer lookup the referrer	to pay, otherwise pay the affiliate	
		IF @Level = 0
			SELECT @Qualify = Qualify, @MemberID = MemberID FROM Member WHERE MemberID = @ReferralID

		IF @Qualify > 1
		BEGIN
			SET @Bonus = @Retail
			SET @CommType = 1
			SET @Desc = @Ref
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END
	END

--	******************************
--	Calculate Fast Start Bonuses
--	******************************
	IF CHARINDEX(@Code, '101,102,103,121,122,123,124,125,126') > 0 
	BEGIN
--		*************************************************
--		Calculate Fast Start Bonuses
--		*************************************************
		SET @Qualify = 0
		SELECT @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @ReferralID

--		Only Silver+ can earn Fast Start Bonuses	
		IF @Qualify > 1 AND @Title >= 2
		BEGIN
			IF @Code = '101' SET @Bonus = 70
			IF @Code = '102' SET @Bonus = 90
			IF @Code = '103' SET @Bonus = 110
			IF @Code = '121' SET @Bonus = 70
			IF @Code = '122' SET @Bonus = 90
			IF @Code = '123' SET @Bonus = 110
			IF @Code = '124' SET @Bonus = 20
			IF @Code = '125' SET @Bonus = 40
			IF @Code = '126' SET @Bonus = 20
			SET @CommType = 2
			SET @Desc = @Ref
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END
	END	

--	************************************************************
--	Calculate Coded Bonuses
--	************************************************************
	IF CHARINDEX(@Code, '101,102,103,121,122,123') > 0 
	BEGIN
		SET @cnt = 0
		EXEC pts_Commission_Company_13c @tmpMemberID, @PaymentID, @Ref, @cnt OUTPUT
		SET @Count = @Count + @cnt
	END	

--	************************************************************
--	Calculate Matrix and Infinity Bonuses (if we have any BV)
--	************************************************************
	IF @Amount >  0
	BEGIN
--		-- Start with the member's matrix sponsor
		SELECT @Level = Level, @MemberID = SponsorID, @ReferralID = ReferralID FROM Member WHERE MemberID = @tmpMemberID
--		-- If this is a retail customer lookup the referrer's matrix sponsor	
		IF @Level = 0
			SELECT @Level = Level, @MemberID = SponsorID, @ReferralID = ReferralID FROM Member WHERE MemberID = @ReferralID

		SET @Level = 1
		WHILE @Level <= 10 AND @MemberID > 0
		BEGIN
--			-- Get the Affiliates info
			SET @SponsorID = 0
			SELECT @SponsorID = SponsorID, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @MemberID

--			--Did we find the member
			IF @SponsorID >= 0
			BEGIN
--			-- Are they qualified for the level (Silver(2)=level 1, Gold(3)=level2, ...)
				IF @Title <= @Level SET @Qualify = 0

--				-- Is this member qualified to receive bonuses, otherwise skip (dynamic compression)
				IF @Qualify > 1
				BEGIN
					SET @Bonus = 0
					IF @Level = 1 SET @Bonus = ROUND(@Amount * .03, 2)
					IF @Level = 2 SET @Bonus = ROUND(@Amount * .14, 2)
					IF @Level = 3 SET @Bonus = ROUND(@Amount * .09, 2)
					IF @Level = 4 SET @Bonus = ROUND(@Amount * .09, 2)
					IF @Level = 5 SET @Bonus = ROUND(@Amount * .15, 2)
					IF @Level = 6 SET @Bonus = ROUND(@Amount * .07, 2)
					IF @Level = 7 SET @Bonus = ROUND(@Amount * .04, 2)
					IF @Level = 8 SET @Bonus = ROUND(@Amount * .05, 2)
					IF @Level = 9 SET @Bonus = ROUND(@Amount * .03, 2)
					IF @Level = 10 SET @Bonus = ROUND(@Amount * .01, 2)

					IF @Bonus > 0
					BEGIN	
						SET @CommType = 4
						SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--						-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
						EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
						SET @Count = @Count + 1
					END
--					-- move to next level to process (dynamic compression)
					SET @Level = @Level + 1
				END 
--				-- Set the memberID to get the next upline Referral
				SET @MemberID = @SponsorID
			END
			ELSE SET @MemberID = 0
		END

						
--	******************************
--	Infinity Bonuses
--	******************************

	END

	FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Retail, @Code, @MemberID, @Ref, @ReferralID
END
CLOSE SalesItem_cursor
DEALLOCATE SalesItem_cursor


-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
