EXEC [dbo].pts_CheckProc 'pts_Commission_Company_7'
GO

--DECLARE @Count int EXEC pts_Commission_Company_7 0, '9/1/13', '9/30/13', @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_7
   @CommType int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

DECLARE @CompanyID int, @Now datetime, @MemberID int, @ReferralID int, @Referral2ID int, @SponsorID int, @Rate money, @Test int
DECLARE @Bonus money, @Desc varchar(100), @Ref varchar(100), @Role varchar(15), @Cnt int, @Amount money, @ID int, @IsCompany int

SET @CompanyID = 7
SET @Count = 0
SET @Now = GETDATE()
SET @Test = 0

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, SponsorID, ReferralID, STR(MemberID) + ' ' + NameFirst + ' ' + NameLast
FROM Member WHERE CompanyID = @CompanyID AND MemberID = GroupID AND Status = 1

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @SponsorID, @ReferralID, @Ref
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @Amount = SUM(Amount) FROM Payment AS pa
	JOIN Member AS me ON pa.OwnerID = me.MemberID
	WHERE me.CompanyID = @CompanyID AND me.GroupID = @MemberID
	AND pa.Status = 3 AND pa.CommStatus = 1
	AND pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate

	IF @Amount > 0
	BEGIN
--		*************************************
--		Caclulate Team Bonus
--		*************************************
		IF @SponsorID > 0
		BEGIN
--			Get total number of active group members (level 2 or 3)
			SELECT @Cnt = COUNT(*) FROM Member WHERE GroupID = @MemberID AND Status = 1 AND (Level = 2 OR Level = 3)

			IF @Cnt < 50 SET @Rate = 0
			IF @Cnt >= 50 AND @Cnt <= 100 SET @Rate = .05
			IF @Cnt >= 101 AND @Cnt <= 500 SET @Rate = .10
			IF @Cnt >= 501 AND @Cnt <= 1000 SET @Rate = .15
			IF @Cnt > 1000 SET @Rate = .20
			
			SET @Bonus = ROUND(@Amount * @Rate, 2)
			IF @Bonus > 0
			BEGIN
				SET @CommType = 1
				SET @Desc = @Ref + ' (' + CAST(@Amount AS VARCHAR(10)) + ' * ' + + CAST(@Rate AS VARCHAR(10)) + ' (' + + CAST(@Cnt AS VARCHAR(10)) + '))'
--				CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				IF @Test = 0 EXEC pts_Commission_Add @ID, @CompanyID, 4, @SponsorID, 0, 0, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
				IF @Test != 0 Print CAST(@SponsorID AS VARCHAR(10)) + ' - ' + @Desc + ' : ' + CAST(@Bonus AS VARCHAR(15))
				SET @Count = @Count + 1
			END
		END

--		**********************************************
--		Caclulate Referral Bonuses for up to 2 levels
--		**********************************************
		SET @Cnt = 0
		WHILE @ReferralID > 0 AND @Cnt < 2
		BEGIN
			SET @Referral2ID = 0
			SET @Role = ''
			SELECT @Referral2ID = ReferralID, @Role = [Role] FROM Member WHERE MemberID = @ReferralID AND [Status] = 1
--			Role contains the bonus rate
			IF @Role <> ''
			BEGIN
				SET @Rate = CAST(@Role AS money)
				SET @Bonus = ROUND(@Amount * @Rate, 2)
				IF @Bonus > 0
				BEGIN
					SET @CommType = 2
					SET @Desc = @Ref + ' (' + CAST(@Amount AS VARCHAR(10)) + ' * ' + + CAST(@Rate AS VARCHAR(10)) + ')'
--					CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
					IF @Test = 0 EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, 0, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
					IF @Test != 0 Print CAST(@ReferralID AS VARCHAR(10)) + ' - ' + @Desc + ' : ' + CAST(@Bonus AS VARCHAR(15))
					SET @Count = @Count + 1
				END
			END
			SET @ReferralID = @Referral2ID
			SET @Cnt = @Cnt + 1
		END

--		Update Payment Commission Status and date
		IF @Test = 0 
		BEGIN
			UPDATE Payment SET CommStatus = 2, CommDate = @Now
			FROM Payment AS pa
			JOIN Member AS me ON pa.OwnerID = me.MemberID
			WHERE me.CompanyID = @CompanyID AND me.GroupID = @MemberID
			AND pa.Status = 3 AND pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate
		END
	END

	FETCH NEXT FROM Member_cursor INTO @MemberID, @SponsorID, @ReferralID, @Ref
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO
