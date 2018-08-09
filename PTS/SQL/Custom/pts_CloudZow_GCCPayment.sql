EXEC [dbo].pts_CheckProc 'pts_CloudZow_GCCPayment'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_GCCPayment 521, @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_GCCPayment
   @Quantity int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @Count int
SET @CompanyID = 5
SET @MemberID = @Quantity

IF @MemberID > 0
BEGIN
--	--	Process GCC Payment Credit
	EXEC pts_CloudZow_GCCCredit @CompanyID, @MemberID
	SET @Count = 1		
END
ELSE
BEGIN
--	-- Check for any international members with no GCC AND they have payouts >= $10
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID FROM Member AS me
	JOIN Address AS ad ON me.MemberID = ad.OwnerID
	WHERE CompanyID = @CompanyID AND Status = 1 AND Level = 1
	AND ad.AddressType = 2 AND ad.IsActive <> 0 AND ad.CountryID <> 224
	AND MemberID NOT IN (
		SELECT OwnerID FROM Payment
		WHERE OwnerID = me.MemberID
		AND PayType = 90 AND Reference = 'GCC'
	)
	AND MemberID IN (
		SELECT OwnerID FROM Payout
		WHERE CompanyID = @CompanyID AND Status = 1
		GROUP BY OwnerID Having SUM(Amount) >= 10
	)

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID
	SET @Count = 0
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Count = @Count + 1
--	--	Process GCC Payment Credit
		EXEC pts_CloudZow_GCCCredit @CompanyID, @MemberID
		FETCH NEXT FROM Member_cursor INTO @MemberID
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor
END

SET @Result = CAST(@Count AS VARCHAR(10))

GO