EXEC [dbo].pts_CheckProc 'pts_Commission_CreateReferrals'
GO

--EXEC pts_Commission_CreateReferrals '5/31/10'

CREATE PROCEDURE [dbo].pts_Commission_CreateReferrals
   @CommDate datetime 
AS

SET NOCOUNT ON

DECLARE @Now datetime, @CommissionID int, @Description nvarchar (100) 
DECLARE @Rate1 money, @Rate2 money , @Commission money 
DECLARE @PaymentID int, @MemberID int, @ReferralID int, @CompanyID int, @Total money, @CommRate money 

SET @Now = GETDATE()

DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT pa.PaymentID, me.MemberID, me.ReferralID, co.CompanyID, pa.Total, cop.CommRate
FROM Payment AS pa 
JOIN Member AS me ON ( pa.OwnerID = me.MemberID AND pa.OwnerType = 4 )
JOIN Company AS co ON me.CompanyID = co.CompanyID
JOIN Coption AS cop ON me.CompanyID = cop.CompanyID
WHERE pa.Status = 3 AND pa.CommStatus < 2 AND pa.PayDate <= @CommDate
AND cop.CommRate < 0
AND me.ReferralID > 0

OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @ReferralID, @CompanyID, @Total, @CommRate 

WHILE @@FETCH_STATUS = 0
BEGIN
--	Get the referral rates - 1st whole number, 2nd fraction
	SET @Rate1 = ABS(ROUND(@CommRate,0,1) / 100)
	SET @Rate2 = ABS(@CommRate - ROUND(@CommRate,0,1))

--	calculate commission for 1st level referral 
	IF @Rate1 <> 0
	BEGIN
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		
		IF @ReferralID > 0
		BEGIN
			SET @Description = 'Refer:[1; ' + CAST( @Rate1 AS VARCHAR(10)) + ' * ' + CAST( @Total AS VARCHAR(20)) + ']'
			SET @Commission = ROUND(@Total * @Rate1,2,1)
--	 		CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate,
-- 			Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @CommissionID OUTPUT, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now,
				1, 1, @Commission, @Commission, 0, @Description, '', 1
		END	
	END
	
--	calculate commission for 2nd level referral 
	IF @Rate2 <> 0 AND @ReferralID > 0
	BEGIN
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @ReferralID
		
		IF @ReferralID > 0
		BEGIN
			SET @Description = 'Refer:[2; ' + CAST( @Rate2 AS VARCHAR(10)) + ' * ' + CAST( @Total AS VARCHAR(20)) + ']'
			SET @Commission = ROUND(@Total * @Rate2,2,1)
--	 		CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate,
-- 			Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @CommissionID OUTPUT, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now,
				1, 2, @Commission, @Commission, 0, @Description, '', 1
		END	
	END

	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @ReferralID, @CompanyID, @Total, @CommRate 
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor

GO

