EXEC [dbo].pts_CheckProc 'pts_CloudZow_UpdateBadPayments'
GO

--DECLARE @Count varchar(1000) EXEC pts_CloudZow_Payments 0, @Count OUTPUT print @Count

CREATE PROCEDURE [dbo].pts_CloudZow_UpdateBadPayments
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @Count int, @PaymentID int, @BillingID int, @tmpDescription varchar(100), @BillingInfo varchar(100)
SET @Count = 0

--**********************************************************************************************************
--Process - Bill Members (Billing = 3)
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
Select pa.PaymentID, me.BillingID
FROM Payment AS pa
JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.BillingID = bi.BillingID
WHERE me.CompanyID = 5 AND me.Status >= 1 AND me.Status <= 4 AND pa.Status = 4
AND bi.UpdatedDate > pa.PayDate

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @PaymentID, @BillingID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Count = @Count + 1
	
--	Get Billing Information
	SET @BillingInfo = ''
	SELECT @BillingInfo = 
		CASE PayType
		WHEN 1 THEN CAST(CardType AS varchar(10)) + '; ' + CardNumber + '; ' + CAST(CardMo AS varchar(10)) + '/' + CAST(CardYr AS varchar(10)) + '; ' + CardCode + '; ' + CardName + '; ' + Street1 + '; ' + Street2 + '; ' + City + '; ' + State + '; ' + Zip + '; ' + co.Code
		WHEN 2 THEN CheckBank + '; ' + CheckRoute + '; ' + CheckAccount + '; ' + CheckNumber + '; ' + CheckName + '; ' + CAST(CheckAcctType AS varchar(2))
		WHEN 4 THEN CAST(CardType AS varchar(10)) + '; ' + CardName
		ELSE ''
		END
	FROM Billing AS bi
	LEFT OUTER JOIN Country AS co ON bi.CountryID = co.CountryID
	WHERE BillingID = @BillingID

	SET @tmpDescription = 'Charged:[' + @BillingInfo + ']'

	UPDATE Payment SET Description = @tmpDescription, Status = 1 WHERE PaymentID = @PaymentID

	FETCH NEXT FROM Member_cursor INTO @PaymentID, @BillingID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@Count AS VARCHAR(10))
GO
