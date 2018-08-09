EXEC [dbo].pts_CheckProc 'pts_Commission_Company_7c'
GO

--DECLARE @Cnt int EXEC pts_Commission_Company_7c 30398, 89978, 7.95, '#89982 Joe Blow', @Cnt OUTPUT

CREATE PROCEDURE [dbo].pts_Commission_Company_7c
   @PaymentID int ,
   @MemberID int ,
   @Amount money ,
   @Ref varchar(100) ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @Now datetime, @A1 int, @A2 int, @A3 int, @A4 int
DECLARE @Qualify int, @Sponsor2ID int, @ReferralID int
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
WHILE @Access <= 4 AND @MemberID > 0
BEGIN
--	-- Get the sponsor's info
	SELECT @Qualify = Qualify, @Sponsor2ID = Sponsor2ID, @ReferralID = ReferralID, @Match = NameFirst + ' ' + NameLast 
	FROM Member WHERE MemberID = @MemberID

--	-- If this sponsor is qualified to receive bonuses, otherwise skip (dynamic compression)
	IF @Qualify > 1
	BEGIN
--		-- Are we paying out the bonus for the current access level
		IF (@Access = 1 AND @A1 = 1) OR (@Access = 2 AND @A2 = 1) OR (@Access = 3 AND @A3 = 1) OR (@Access = 4 AND @A4 = 1)
		BEGIN
			SET @CommType = 20
			IF @Access = 1 SET @Bonus = 5
			IF @Access = 2 SET @Bonus = 5
			IF @Access = 3 SET @Bonus = 10
			IF @Access = 4 SET @Bonus = 20
			SET @Desc = @Ref + ' (' + CAST( @Access AS VARCHAR(2) ) + ')'

--			-- Pay Intro Bonus regardless of their title
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
			SET @Count = @Count + 1

--			-- Pay Intro Matching Bonus for levels 2 - 4
			IF @Access > 1 AND @ReferralID > 0
			BEGIN
				SET @CommType = 21
				SET @Desc = '#' + CAST(@MemberID AS VARCHAR(10)) + ' ' + @Match + ' - ' + @Desc
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
				SET @Count = @Count + 1
			END
		END 
		SET @Access = @Access + 1
	END 
--	-- Set the memberID to get the next upline sponsor2
	SET @MemberID = @Sponsor2ID
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
