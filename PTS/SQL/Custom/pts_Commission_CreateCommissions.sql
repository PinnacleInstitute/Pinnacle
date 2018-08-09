EXEC [dbo].pts_CheckProc 'pts_Commission_CreateCommissions'
GO

--TEST---------------------------------------------------------
--DECLARE @Count int 
--EXEC pts_Commission_CreateCommissions '5/31/05', @Count OUTPUT
--PRINT CAST(@Count AS VARCHAR)

CREATE PROCEDURE [dbo].pts_Commission_CreateCommissions
   @CommDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @CommissionID int, @OwnerType int, @Description nvarchar (100) 
DECLARE @Now datetime, @CommRate money, @EnrollDate datetime, @Months int

SET @Now = GETDATE()
SET @Count = 0
IF @CommDate = 0 SET @CommDate = @Now

--**********************************************************************************************************
--Validate that all Trainer Scores have been calculated
--**********************************************************************************************************
DECLARE @SessionCount int, @MemberAssessCount int

SELECT @SessionCount = COUNT(se.SessionID)
FROM Session AS se JOIN Course AS co ON se.CourseID = co.CourseID
WHERE co.CompanyID = 0 AND co.IsPaid = 1 AND se.TrainerScore = 0 AND se.CompleteDate != 0 AND se.CompleteDate <= @CommDate  

SELECT @MemberAssessCount = COUNT(ma.MemberAssessID)
FROM MemberAssess AS ma JOIN Assessment AS am ON ma.AssessmentID = am.AssessmentID
WHERE am.CompanyID = 0 AND am.IsPaid = 1 AND ma.TrainerScore = 0 AND ma.CompleteDate != 0 AND ma.CompleteDate <= @CommDate

IF @SessionCount > 0 OR @MemberAssessCount > 0
BEGIN
--	return a negative number of unprocessed trainer scores
	SET @Count = -1 * (@SessionCount + @MemberAssessCount)
END
ELSE
BEGIN
--	**********************************************************************************************************
--	Process all retail commissions - for company - sum(retail) of all company member payments 
--	**********************************************************************************************************
	DECLARE @CompanyID int, @Amount money, @Commission money, @Cnt int
	
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT me.CompanyID, SUM(pa.Retail), COUNT(pa.PaymentID)
	FROM Payment AS pa 
	JOIN Member AS me ON ( pa.OwnerID = me.MemberID AND pa.OwnerType = 4 )
	WHERE pa.Status = 3 AND pa.CommStatus < 2 AND pa.PayDate <= @CommDate
	GROUP BY me.CompanyID
	
	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @CompanyID, @Amount, @Cnt
	
-- 	set commission owner type to company (38)
	SET @OwnerType = 38
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Description = 'Retail:[' + CAST( @Cnt AS VARCHAR(10)) + ']'
	
--	 	CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate,
-- 		Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @CommissionID OUTPUT, 0, @OwnerType, @CompanyID, 0, 0, @Now,
			1, 1, @Amount, @Amount, 0, @Description, '', 1
		SET @Count = @Count + 1
	
--PRINT CAST(@CompanyID AS VARCHAR) + ', ' +CAST(@Amount AS VARCHAR) + ', ' + CAST(@Cnt AS VARCHAR) 
		FETCH NEXT FROM Payment_cursor INTO @CompanyID, @Amount, @Cnt
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor

--	**********************************************************************************************************
--	Process Referral Fees - for referring member(s) - of each member payment
--	**********************************************************************************************************
	EXEC pts_Commission_CreateReferrals @CommDate

--	**********************************************************************************************************
--	Process Sales commissions - for members - sum(commission) of each company & member payments
--	**********************************************************************************************************
	DECLARE @MemberID int

	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT me.CompanyID, SUM(pa.Commission), COUNT(pa.PaymentID)
	FROM Payment AS pa 
	JOIN Member AS me ON ( pa.OwnerID = me.MemberID AND pa.OwnerType = 4 )
	WHERE pa.Status = 3 AND pa.CommStatus < 2 AND pa.PayDate <= @CommDate
	GROUP BY me.CompanyID

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @CompanyID, @Amount, @Cnt

	WHILE @@FETCH_STATUS = 0
	BEGIN
--		Get the Member for this company
		SELECT @MemberID = 0
		SELECT @MemberID = MemberID, @EnrollDate = EnrollDate
		FROM Company WHERE CompanyID = @CompanyID

		SELECT @CommRate = CommRate FROM Coption WHERE CompanyID = @CompanyID

		IF @CommRate > 0
		BEGIN
--			set commission owner type to Member (4)
			SET @OwnerType = 4

-- --------------------	CREATE Member Commission -------------------------------------------------------------------
			IF @MemberID = 0 SET @OwnerType = 0

			SET @Description = 'Sale:[' + CAST( @Cnt AS VARCHAR(10)) + '; ' + CAST( @Amount AS VARCHAR(20)) + ' * ' + CAST( @CommRate AS VARCHAR(20)) + ']'
			SET @Commission = @Amount * @CommRate

--	 		CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate,
-- 			Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @CommissionID OUTPUT, 0, @OwnerType, @MemberID, 0, @CompanyID, @Now,
				1, 2, @Commission, @Commission, 0, @Description, '', 1
			SET @Count = @Count + 1
----PRINT 'Executive ' + CAST(@MemberID AS VARCHAR) + ', ' +CAST(@Commission AS VARCHAR) + ', ' + @Description
		END

		FETCH NEXT FROM Payment_cursor INTO @CompanyID, @Amount, @Cnt
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor

--	**********************************************************************************************************
--	Process Sales commissions - for companies - sum(commission) of company payments
--	**********************************************************************************************************
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT co.CompanyID, SUM(pa.Commission), COUNT(pa.PaymentID)
	FROM Payment AS pa 
	JOIN Company AS co ON ( pa.OwnerID = co.CompanyID AND pa.OwnerType = 38 )
	WHERE pa.Status = 3 AND pa.CommStatus < 2 AND pa.PayDate <= @CommDate
	GROUP BY co.CompanyID

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @CompanyID, @Amount, @Cnt

	WHILE @@FETCH_STATUS = 0
	BEGIN
--		Get the Member for this company
		SELECT @MemberID = 0
		SELECT @MemberID = MemberID, @EnrollDate = EnrollDate
		FROM Company WHERE CompanyID = @CompanyID

		SELECT @CommRate = CommRate FROM Coption WHERE CompanyID = @CompanyID

		IF @CommRate > 0
		BEGIN
--			set commission owner type to Member (4)
			SET @OwnerType = 4

-- --------------------	CREATE Member Commission -------------------------------------------------------------------
			IF @MemberID = 0 SET @OwnerType = 0

			SET @Description = 'Sale:[' + CAST( @Cnt AS VARCHAR(10)) + '; ' + CAST( @Amount AS VARCHAR(20)) + ' * ' + CAST( @CommRate AS VARCHAR(20)) + ']'
			SET @Commission = @Amount * @CommRate

--	 		CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate,
-- 			Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @CommissionID OUTPUT, 0, @OwnerType, @MemberID, 0, @CompanyID, @Now,
				1, 2, @Commission, @Commission, 0, @Description, '', 1
			SET @Count = @Count + 1
----PRINT 'Executive ' + CAST(@MemberID AS VARCHAR) + ', ' +CAST(@Commission AS VARCHAR) + ', ' + @Description
		END

		FETCH NEXT FROM Payment_cursor INTO @CompanyID, @Amount, @Cnt
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor

--	**********************************************************************************************************
--	Process Trainer Course commissions - sum(trainerscore) of all sessions per class / totalscores * total$
--	**********************************************************************************************************
--	DECLARE @TrainerID int, @CourseID int, @Score int, @TotalRevenue money, @TotalScore int, @Factor float
--	DECLARE @TotalSessionScore int, @TotalMemberAssessScore int 
--	
-- 	Get the total revenue for all approved payments to be paid commissions
--	SELECT @TotalRevenue = SUM(Commission) FROM Payment WHERE Status = 3 AND CommStatus < 2 AND PayDate <= @CommDate
--	SET @TotalRevenue = @TotalRevenue * .1
--	
-- 	Get the total trainer score for all completed sessions with trainer scores and to be commissioned
--	SELECT @TotalSessionScore = SUM(TrainerScore) FROM Session WHERE TrainerScore > 0 AND CommStatus < 2 AND CompleteDate != 0 AND CompleteDate <= @CommDate
--	
-- 	Get the total trainer score for all completed member assessments with trainer scores and to be commissioned
--	SELECT @TotalMemberAssessScore = SUM(TrainerScore) FROM MemberAssess WHERE TrainerScore > 0 AND CommStatus < 2 AND CompleteDate != 0 AND CompleteDate <= @CommDate
--	
--	SET @TotalScore = @TotalSessionScore + @TotalMemberAssessScore
--
--	DECLARE Session_cursor CURSOR LOCAL STATIC FOR 
--	SELECT co.TrainerID, se.CourseID, SUM(se.TrainerScore), COUNT(se.SessionID)
--	FROM Session AS se JOIN Course AS co ON se.CourseID = co.CourseID
--	WHERE co.CompanyID = 0 AND co.IsPaid = 1 AND se.TrainerScore > 0 AND se.CommStatus < 2 AND se.CompleteDate != 0 AND se.CompleteDate <= @CommDate
--	GROUP BY co.TrainerID, se.CourseID
--	
--	OPEN Session_cursor
--	FETCH NEXT FROM Session_cursor INTO @TrainerID, @CourseID, @Score, @Cnt
--	
--	set commission owner type to trainer (3)
--	SET @OwnerType = 3
--	
--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--	 	Calculate percentage of total revenue for this course
--		SET @Commission = ( CAST(@Score AS FLOAT) / CAST(@TotalScore AS FLOAT) ) * @TotalRevenue
--		SET @Description = 'Course:[' + CAST( @Cnt AS VARCHAR(10)) + '; ' + CAST( @Score AS VARCHAR(20)) + 'pts]'
--
--	 	CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate,
-- 		Status, CommType, Amount, Total, Charge, Description, Notes, UserID
--		EXEC pts_Commission_Add @CommissionID OUTPUT, 0, @OwnerType, @TrainerID, 0, @CourseID, @Now,
--			1, 6, @Commission, @Commission, 0, @Description, '', 1
--		SET @Count = @Count + 1
--	
--		FETCH NEXT FROM Session_cursor INTO @TrainerID, @CourseID, @Score, @Cnt
--	END
--	CLOSE Session_cursor
--	DEALLOCATE Session_cursor
	
--	**********************************************************************************************************
--	 Process Trainer Assessment commissions - sum(trainerscore) of all member assess per assessment / totalscores * total$
--	**********************************************************************************************************
--	DECLARE @AssessmentID int
--	
--	DECLARE MemberAssess_cursor CURSOR LOCAL STATIC FOR 
--	SELECT am.TrainerID, ma.AssessmentID, SUM(ma.TrainerScore), COUNT(ma.MemberAssessID)
--	FROM MemberAssess AS ma JOIN Assessment AS am ON ma.AssessmentID = am.AssessmentID
--	WHERE am.CompanyID = 0 AND am.IsPaid = 1 AND ma.TrainerScore > 0 AND ma.CommStatus < 2 AND ma.CompleteDate != 0 AND ma.CompleteDate <= @CommDate
--	GROUP BY am.TrainerID, ma.AssessmentID
--	
--	OPEN MemberAssess_cursor
--	FETCH NEXT FROM MemberAssess_cursor INTO @TrainerID, @AssessmentID, @Score, @Cnt
--	
-- 	set commission owner type to trainer (3)
--	SET @OwnerType = 3
--	
--	WHILE @@FETCH_STATUS = 0
--	BEGIN
-- 		Calculate percentage of total revenue for this assessment
--		SET @Commission = ( CAST(@Score AS FLOAT) / CAST(@TotalScore AS FLOAT) ) * @TotalRevenue
--		SET @Description = 'Assessment:[' + CAST( @Cnt AS VARCHAR(10)) + '; ' + CAST( @Score AS VARCHAR(20)) + 'pts]'
--	
--	 	CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate,
-- 		Status, CommType, Amount, Total, Charge, Description, Notes, UserID
--		EXEC pts_Commission_Add @CommissionID OUTPUT, 0, @OwnerType, @TrainerID, 0, @AssessmentID, @Now,
--			1, 7, @Commission, @Commission, 0, @Description, '', 1
--		SET @Count = @Count + 1
--
--		FETCH NEXT FROM MemberAssess_cursor INTO @TrainerID, @AssessmentID, @Score, @Cnt
--	END
--	CLOSE MemberAssess_cursor
--	DEALLOCATE MemberAssess_cursor

--	**********************************************************************************************************
-- 	Update Payment, Session and MemberAssess commission = 2
--	**********************************************************************************************************
--	Mark Commissions Paid for all approved commissionable payments 
	UPDATE Payment SET CommStatus = 2 WHERE Status = 3 AND CommStatus < 2 AND PayDate <= @CommDate

--	Mark Commissions Paid for all public paid courses
	UPDATE se SET CommStatus = 2
	FROM Session AS se JOIN Course AS co ON se.CourseID = co.CourseID
	WHERE co.CompanyID = 0 AND co.IsPaid = 1 AND se.TrainerScore > 0 AND se.CommStatus < 2 AND se.CompleteDate != 0 AND se.CompleteDate <= @CommDate

--	Mark Commissions Paid for all completed member assessments for public paid assessments
	UPDATE ma SET CommStatus = 2
	FROM MemberAssess AS ma JOIN Assessment AS am ON ma.AssessmentID = am.AssessmentID
	WHERE am.CompanyID = 0 AND am.IsPaid = 1 AND ma.TrainerScore > 0 AND ma.CommStatus < 2 AND ma.CompleteDate != 0 AND ma.CompleteDate <= @CommDate
END

GO
