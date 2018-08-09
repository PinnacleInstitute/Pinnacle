EXEC [dbo].pts_CheckProc 'pts_Commission_Company_20a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_20a 33543, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_20a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @NextReferralID int, @Sponsor2ID int, @Sponsor3ID int, @Level int, @Level2 int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @Retail money 
DECLARE @tmpMemberID int, @FastStart int, @cnt int, @Price money, @BV money
DECLARE @CommPlan int, @Amount money, @Code varchar(10), @MemberID int, @Ref varchar(100), @Options2 varchar(100), @tmpOptions2 varchar(100)
DECLARE @EnrollDate datetime, @PinnacleID int, @Personal int
DECLARE @QVLeft money, @QVRight money

SET @CompanyID = 20
SET @Count = 0
SET @Now = GETDATE()

DECLARE SalesItem_cursor CURSOR LOCAL STATIC FOR 
SELECT pr.CommPlan, si.Quantity * pr.BV, si.Quantity * pr.OriginalPrice, pr.Code, me.MemberID, LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, me.Options2, me.ReferralID 
FROM   SalesItem AS si
JOIN   SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
JOIN   Product AS pr ON si.ProductID = pr.ProductID
JOIN   Member AS me ON so.MemberID = me.MemberID 
JOIN   Payment AS pa ON pa.OwnerType = 52 AND so.SalesOrderID = pa.OwnerID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1
--AND	   pr.BV > 0 
AND so.Status <= 3 AND si.Status <= 3

OPEN SalesItem_cursor
FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Retail, @Code, @MemberID, @Ref, @Options2, @ReferralID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @tmpMemberID = @MemberID
	SET @FastStart = 0

--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
	SET @Bonus = 0
	IF @Code = '101' SET @Bonus = 1
	IF @Code = '102' SET @Bonus = 1
	IF @Code = '103' SET @Bonus = 1
	IF @Code = '104' SET @Bonus = 1
		
	IF @Bonus > 0
	BEGIN
		SET @PinnacleID = 22715
		SET @CommType = 10
		SET @Desc = @Ref
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END

--	***********************************************************************
--	Calculate Team Bonuses
--	***********************************************************************
	IF CHARINDEX(@Code,'101,102,103,104') > 0
	BEGIN
	--	-- Start with the member's enroller (upline)
		SET @MemberID = @ReferralID
		SET @CommType = 1

		SET @Level = 1
		WHILE @Level <= 10 AND @MemberID > 0
		BEGIN
--			-- Set Bonus
			IF @Level IN (1,2,4,5) SET @Bonus = @Amount * .05
			IF @Level IN (3) SET @Bonus = @Amount * .15
			IF @Level IN (6,7,8,9,10) SET @Bonus = @Amount * .02
		
--		-- Get the Referrer's info
			SET @ReferralID = -1
			SELECT @ReferralID = ReferralID, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @MemberID

	--		--Did we find the member
			IF @ReferralID >= 0
			BEGIN
--				-- Check if qualified for level based on personals
				SELECT @Personal = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status = 1
				IF @Personal + 1 < @Level SET @Qualify = 0
			
				IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @MemberID

				IF @Qualify > 1 
				BEGIN
					SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
					EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
					SET @Count = @Count + 1

	--				-- move to next level to process (dynamic compression)
					SET @Level = @Level + 1
				END 
	--			-- Set the memberID to get the next upline Referral
				SET @MemberID = @ReferralID
			END
			ELSE SET @MemberID = 0
		END
	END
		
--	************************************************************
--	Calculate Coded Bonuses
--	************************************************************
	SET @MemberID = @tmpMemberID
	SET @cnt = 0
	EXEC pts_Commission_Company_20c @MemberID, @PaymentID, @Amount, @Ref, @cnt OUTPUT
	SET @Count = @Count + @cnt
		
	FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Retail, @Code, @MemberID, @Ref, @Options2, @ReferralID
END
CLOSE SalesItem_cursor
DEALLOCATE SalesItem_cursor


-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
