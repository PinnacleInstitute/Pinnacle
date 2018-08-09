-- FAB Bonuses

DECLARE @ID int, @Bonus money, @MemberID int, @Today datetime, @Test int
SET @Today = dbo.wtfn_DateOnly(GETDATE())

-- *************************
--SELECT $794.67 / 6
SET @Bonus = 132.45
SET @Test = 1
-- *************************

--	PayoutID OUTPUT, CompanyID, OwnerType, OwnerID, PayDate, PaidDate, Amount, Status, Notes, PayType, Reference, Show, UserID

SET @MemberID = 12551 -- Linda Helin
IF @Test = 0 EXEC pts_Payout_Add @ID OUTPUT, 17, 4, @MemberID, @Today, @Today, @Bonus, 1, '', 91, 'FAB', 0, 1

SET @MemberID = 19469 -- Lisa Fields
IF @Test = 0 EXEC pts_Payout_Add @ID OUTPUT, 17, 4, @MemberID, @Today, @Today, @Bonus, 1, '', 91, 'FAB', 0, 1

SET @MemberID = 12556 -- Sasa
IF @Test = 0 EXEC pts_Payout_Add @ID OUTPUT, 17, 4, @MemberID, @Today, @Today, @Bonus, 1, '', 91, 'FAB', 0, 1

SET @MemberID = 12561 -- Ruben
IF @Test = 0 EXEC pts_Payout_Add @ID OUTPUT, 17, 4, @MemberID, @Today, @Today, @Bonus, 1, '', 91, 'FAB', 0, 1

SET @MemberID = 14904 -- Vincente Luz
IF @Test = 0 EXEC pts_Payout_Add @ID OUTPUT, 17, 4, @MemberID, @Today, @Today, @Bonus, 1, '', 91, 'FAB', 0, 1

SET @MemberID = 14565 -- Kristina
IF @Test = 0 EXEC pts_Payout_Add @ID OUTPUT, 17, 4, @MemberID, @Today, @Today, @Bonus, 1, '', 91, 'FAB', 0, 1


