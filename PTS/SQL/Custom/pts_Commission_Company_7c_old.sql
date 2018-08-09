EXEC [dbo].pts_CheckProc 'pts_Commission_Company_7c'
GO

--DECLARE @Cnt int
--EXEC pts_Commission_Company_7c 28938, 88708, 81.95, '#88708 Welton Jones', @Cnt OUTPUT

CREATE PROCEDURE [dbo].pts_Commission_Company_7c
   @PaymentID int ,
   @MemberID int ,
   @Amount money ,
   @Ref varchar(100) ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @Now datetime, @A1 int, @A2 int, @A3 int, @A4 int, @Title int
DECLARE @Qualify int, @Sponsor2ID int, @ReferralID int, @Levels int, @Level int
DECLARE @Bonus money, @Access int, @ID int, @Desc varchar(100), @EnrollDate datetime, @CommType int, @Match varchar(100)

SET @CompanyID = 7
SET @Count = 0
SET @Now = GETDATE()
SET @A1 = 0 
SET @A2 = 0 
SET @A3 = 0 
SET @A4 = 0 

-- set intro access bonuses to pay
-- purchase 1wk
IF @Amount = 7.95 BEGIN SET @A1 = 1 END
-- purchase 1mo
IF @Amount = 18.95 BEGIN SET @A1 = 1 SET @A2 = 1 END
-- purchase 3mo
IF @Amount = 39.95 BEGIN SET @A1 = 1 SET @A2 = 1 SET @A3 = 1 END
-- purchase 9mo
IF @Amount = 81.95 BEGIN SET @A1 = 1 SET @A2 = 1 SET @A3 = 1 SET @A4 = 1 END
-- upgrade 1wk -> 1mo
IF @Amount = 13.95 BEGIN SET @A2 = 1 END
-- upgrade 1wk -> 3mo
IF @Amount = 34.95 BEGIN SET @A2 = 1 SET @A3 = 1 END
-- upgrade 1wk -> 9mo
IF @Amount = 76.95 BEGIN SET @A2 = 1 SET @A3 = 1 SET @A4 = 1 END
-- upgrade 1mo -> 3mo
IF @Amount = 24.95 BEGIN SET @A3 = 1 END
-- upgrade 1mo -> 9mo
IF @Amount = 66.95 BEGIN SET @A3 = 1 SET @A4 = 1 END
-- upgrade 3mo -> 9mo
IF @Amount = 46.95 BEGIN SET @A4 = 1 END

-- Get the member's sponsor2
SELECT @MemberID = Sponsor2ID FROM Member WHERE MemberID = @MemberID

-- Process Intro Matrix Bonuses for the next 4 qualified upline sponsor2s
SET @Access = 1
SET @Levels = 1
WHILE @Access <= 4 AND @MemberID > 0
BEGIN
--	-- Get the sponsor's info
	SELECT @Title = Title, @Level = [Level], @Qualify = Qualify, @Sponsor2ID = Sponsor2ID, @ReferralID = ReferralID, @Match = NameFirst + ' ' + NameLast 
	FROM Member WHERE MemberID = @MemberID

--	-- If this sponsor is qualified to receive bonuses, otherwise skip (dynamic compression)
	IF @Qualify > 1
	BEGIN
--		-- Are we paying out the bonus for the current access level
		IF (@Access = 1 AND @A1 = 1) OR (@Access = 2 AND @A2 = 1) OR (@Access = 3 AND @A3 = 1) OR (@Access = 4 AND @A4 = 1)
		BEGIN
--			-- Set Title for Intro Bonus processing
--			-- Check for Standard Membership
			IF @Level = 1 SET @Title = 4
--			-- Check for Basic Membership
			IF @Level = 2 SET @Title = 4
--			-- Check for Intro Membership
			IF @Level = 3 SET @Title = @Title - 10

--			-- If we are processing the 1wk Access bonus and the current member's title is at least 1 (11)
--			-- and he is at least 1 level above the purchaser 			
			IF @Access = 1 AND @A1 = 1 AND @Title >= @Access AND @Levels >= @Access
			BEGIN
				SET @CommType = 20
				SET @Bonus = 5
				SET @Desc = @Ref + ' (' + CAST( @Access AS VARCHAR(2) ) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
--PRINT CAST(@Access AS VARCHAR(10)) + ' - ' + CAST(@CommType AS VARCHAR(10)) + ' - ' +  CAST(@Bonus AS VARCHAR(10)) + ' - ' +  CAST(@MemberID AS VARCHAR(10))
				SET @Count = @Count + 1
				SET @Access = @Access + 1
			END
--			-- If we are processing the 1mo Access bonus and the current member's title is at least 2 (12)
--			-- and he is at least 2 levels above the purchaser 			
			IF @Access = 2 AND @A2 = 1 AND @Title >= @Access AND @Levels >= @Access
			BEGIN
				SET @CommType = 20
				SET @Bonus = 5
				SET @Desc = @Ref + ' (' + CAST( @Access AS VARCHAR(2) ) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
--PRINT CAST(@Access AS VARCHAR(10)) + ' - ' + CAST(@CommType AS VARCHAR(10)) + ' - ' +  CAST(@Bonus AS VARCHAR(10)) + ' - ' +  CAST(@MemberID AS VARCHAR(10))
				SET @Count = @Count + 1
--				-- Pay Intro Matching Bonus
				IF @ReferralID > 0
				BEGIN
					SET @CommType = 21
					SET @Desc = '#' + CAST(@MemberID AS VARCHAR(10)) + ' ' + @Match + ' - ' + @Desc
					EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
--PRINT CAST(@Access AS VARCHAR(10)) + ' - ' + CAST(@CommType AS VARCHAR(10)) + ' - ' +  CAST(@Bonus AS VARCHAR(10)) + ' - ' +  CAST(@ReferralID AS VARCHAR(10))
					SET @Count = @Count + 1
				END
				SET @Access = @Access + 1
			END
--			-- If we are processing the 3mo Access bonus and the current member's title is at least 3 (13)
--			-- and he is at least 3 levels above the purchaser 			
			IF @Access = 3 AND @A3 = 1 AND @Title >= @Access AND @Levels >= @Access
			BEGIN
				SET @CommType = 20
				SET @Bonus = 10
					SET @Desc = '#' + CAST(@MemberID AS VARCHAR(10)) + ' ' + @Match + ' - ' + @Desc
				SET @Desc = @Ref + ' (' + CAST( @Access AS VARCHAR(2) ) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
--PRINT CAST(@Access AS VARCHAR(10)) + ' - ' + CAST(@CommType AS VARCHAR(10)) + ' - ' +  CAST(@Bonus AS VARCHAR(10)) + ' - ' +  CAST(@MemberID AS VARCHAR(10))
				SET @Count = @Count + 1
--				-- Pay Intro Matching Bonus
				IF @ReferralID > 0
				BEGIN
					SET @CommType = 21
					SET @Desc = '#' + CAST(@MemberID AS VARCHAR(10)) + ' ' + @Match + ' - ' + @Desc
					EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
--PRINT CAST(@Access AS VARCHAR(10)) + ' - ' + CAST(@CommType AS VARCHAR(10)) + ' - ' +  CAST(@Bonus AS VARCHAR(10)) + ' - ' +  CAST(@ReferralID AS VARCHAR(10))
					SET @Count = @Count + 1
				END
				SET @Access = @Access + 1
			END
--			-- If we are processing the 9mo Access bonus and the current member's title is at least 4 (14)
--			-- and he is at least 4 levels above the purchaser 			
			IF @Access = 4 AND @A4 = 1 AND @Title >= @Access AND @Levels >= @Access
			BEGIN
				SET @CommType = 20
				SET @Bonus = 20
				SET @Desc = @Ref + ' (' + CAST( @Access AS VARCHAR(2) ) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
--PRINT CAST(@Access AS VARCHAR(10)) + ' - ' + CAST(@CommType AS VARCHAR(10)) + ' - ' +  CAST(@Bonus AS VARCHAR(10)) + ' - ' +  CAST(@MemberID AS VARCHAR(10))
				SET @Count = @Count + 1
--				-- Pay Intro Matching Bonus
				IF @ReferralID > 0
				BEGIN
					SET @CommType = 21
					SET @Desc = '#' + CAST(@MemberID AS VARCHAR(10)) + ' ' + @Match + ' - ' + @Desc
					EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
--PRINT CAST(@Access AS VARCHAR(10)) + ' - ' + CAST(@CommType AS VARCHAR(10)) + ' - ' + CAST(@Bonus AS VARCHAR(10)) + ' - ' +  CAST(@ReferralID AS VARCHAR(10))
					SET @Count = @Count + 1
				END
				SET @Access = @Access + 1
			END
		END 
		ELSE
		BEGIN
			SET @Access = @Access + 1
		END 
	END 
--	-- Set the memberID to get the next upline sponsor2
	SET @MemberID = @Sponsor2ID
	SET @Levels = @Levels + 1
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
