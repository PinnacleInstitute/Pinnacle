-- ************************************************************************************
-- Create Bonus records to bill for Premium Memberships
-- ************************************************************************************

SET NOCOUNT ON

DECLARE @ID int, @MemberID int, @CompanyID int, @Title int, @QV money, @BonusID int, @Reference varchar (20) 

DECLARE @BonusDate datetime
SET @BonusDate = dbo.wtfn_DateOnly(GETDATE())
SET @BonusDate = CAST(Month(@BonusDate) as varchar(10)) + '/1/' + CAST(Year(@BonusDate) as varchar(10))
--SET @BonusDate = '11/1/08'

-- ************************************************************************************
-- get all members that have Premium Membership(Billing=3) but do not have a bonus record
-- ************************************************************************************
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT me.MemberID, me.Title, me.QV
FROM Member AS me
LEFT OUTER JOIN Bonus AS bo ON (me.MemberID = bo.MemberID AND bo.BonusDate = @BonusDate)
--LEFT OUTER JOIN Bonus AS bo ON (me.MemberID = bo.MemberID AND bo.BonusDate = '11/1/08')
WHERE me.CompanyID = 582
AND me.Billing = 3
AND bo.BonusID IS NULL

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title, @QV
WHILE @@FETCH_STATUS = 0
BEGIN
--	-- BonusID,CompanyID,MemberID,BonusDate,Title,BV,QV,Total,PaidDate, Reference, IsPrivate, UserID
	EXEC pts_Bonus_Add @ID, 582, @MemberID, @BonusDate, @Title, 0, @QV, 0, 0, '', 1, 1 
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title, @QV
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


-- ************************************************************************************
-- get all members that have Premium Membership(Billing=3)
-- ************************************************************************************
--DECLARE @ID int, @MemberID int, @CompanyID int, @Title int, @QV money, @BonusID int, @Reference varchar (20) 
--DECLARE @BonusDate datetime
--SET @BonusDate = '11/1/08'
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT me.MemberID, bo.BonusID 
FROM Member AS me
JOIN Bonus AS bo ON (me.MemberID = bo.MemberID AND bo.BonusDate = @BonusDate)
--JOIN Bonus AS bo ON (me.MemberID = bo.MemberID AND bo.BonusDate = '11/1/08')
WHERE me.CompanyID = 582 AND me.Billing = 3
--and bo.total >= 20

SET @Reference = CAST(@BonusDate AS VARCHAR(20))

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @BonusID
WHILE @@FETCH_STATUS = 0
BEGIN
--	-- BonusItemID,BonusID,CompanyID,MemberID,MemberBonusID,CommType,Amount,Reference,UserID
	EXEC pts_BonusItem_Add @ID, 0, 582, @MemberID, @BonusID, 10, -9.95, @Reference, 1
--	-- recompute total for member's bonus record
	EXEC pts_Bonus_ComputeTotal @BonusID

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @BonusID
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

GO

-- ************************************************************************************
-- general recompute bonus totals
-- ************************************************************************************
DECLARE @BonusID int
DECLARE Bonus_Cursor CURSOR LOCAL STATIC FOR 
SELECT BonusID FROM Bonus WHERE CompanyID = 582 AND BonusDate = '11/1/08'

OPEN Bonus_Cursor
FETCH NEXT FROM Bonus_Cursor INTO @BonusID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Bonus_ComputeTotal @BonusID
	FETCH NEXT FROM Bonus_Cursor INTO @BonusID
END
CLOSE Bonus_Cursor
DEALLOCATE Bonus_Cursor

