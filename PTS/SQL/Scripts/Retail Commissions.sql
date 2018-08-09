
DECLARE @CompanyID int, @Today datetime, @PaymentID int, @MemberID int, @Title int, @Qualify int, @QualifyLevel int, @SponsorID int, @ReferralID int
DECLARE @Bonus money, @Level int, @ID int, @Desc varchar(100), @Ref varchar(100), @Amount money, @PayDate datetime
DECLARE @tmpCount int, @CommType int, @EnrollDate datetime, @tmpDate datetime

SET @CompanyID = 5
SET @Today = GETDATE()

-- ************************************************************
-- 	Get all already commissioned payments for customer payments
-- so we can pay the reseller
-- ************************************************************
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	select sp.memberid, sum(pa.Amount) from Payment as pa
	join Member as me on pa.OwnerID = me.MemberID
	join Member as sp on me.referralID = sp.MemberID
	where sp.title <= 1
	and me.level = 0
	and pa.CommStatus = 2
	group by sp.memberid
	order by sum(pa.Amount) desc

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @MemberID, @Amount
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @CommType = 1
		SET @Bonus = ROUND(@Amount * .10, 2)
	
		EXEC pts_Commission_Add @ID, 5, 4, @MemberID, 0, 0, @Today, 1, @CommType, @Bonus, @Bonus, 0, 'Previous Retail Commissions', '', 1, 1

		FETCH NEXT FROM Payment_cursor INTO @MemberID, @Amount
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor

GO
