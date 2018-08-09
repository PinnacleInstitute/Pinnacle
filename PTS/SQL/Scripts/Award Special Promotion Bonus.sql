-- **********************************
-- Award Special Promotion Bonuses
-- **********************************

DECLARE @MemberID int, @ID int, @Today datetime, @CommType int, @Bonus money, @Desc varchar(1000)
SET @Today = GETDATE()
SET @CommType = 50
SET @Bonus = 50
SET @Desc = 'Prelaunch Bonus'
--SET @MemberID = 3496
SET @MemberID = 3552

--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
EXEC pts_Commission_Add @ID, 5, 4, @MemberID, 0, 0, @Today, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1

