EXEC [dbo].pts_CheckProc 'pts_Commission_Company_16a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_16a 24601, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_16a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @PinnacleID int, @ID int, @Now datetime
DECLARE @Code varchar(100), @MemberID int, @Ref varchar(100), @ReferralID int
DECLARE @Bonus money, @Desc varchar(100), @CommType int

SET @CompanyID = 16
SET @Now = GETDATE()

DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT pa.Purpose, me.MemberID, LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, me.ReferralID 
FROM   Payment AS pa
JOIN   Member AS me ON pa.OwnerID = me.MemberID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1

OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @Code, @MemberID, @Ref, @ReferralID
WHILE @@FETCH_STATUS = 0
BEGIN
--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
	SET @Bonus = 0
	IF @Code = '100' SET @Bonus = 3  -- Profile
		
	IF @Bonus > 0
	BEGIN
		SET @PinnacleID = 10766
		SET @CommType = 10
		SET @Desc = @Ref
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END
		
	FETCH NEXT FROM Payment_cursor INTO @Code, @MemberID, @Ref, @ReferralID
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor


-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
