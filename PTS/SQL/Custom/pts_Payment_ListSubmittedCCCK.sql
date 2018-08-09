EXEC [dbo].pts_CheckProc 'pts_Payment_ListSubmittedCCCK'
GO

--EXEC pts_Payment_ListSubmittedCCCK 21, 4, 0

CREATE PROCEDURE [dbo].pts_Payment_ListSubmittedCCCK
   @CompanyID int ,
   @OwnerType int ,
   @PayDate datetime
AS

SET NOCOUNT ON

DECLARE @Verified int

IF @PayDate = 0 SET @PayDate = '1/1/2099'

IF @CompanyID > 0 
BEGIN
	IF @OwnerType = 4
	BEGIN
		SELECT pa.PaymentID, pa.Amount, pa.PayType, pa.Description, pa.Purpose, pa.TokenType, pa.TokenOwner, pa.Token
		FROM Payment AS pa (NOLOCK)
		JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID
		AND pa.PayDate <= @PayDate
		AND pa.Status = 1
		AND ((pa.PayType >= 1 AND pa.PayType <= 5 ) Or pa.PayType = 10)
		AND pa.Amount <> 0
		ORDER BY pa.PaymentID
	END
	IF @OwnerType = 52
	BEGIN
		SELECT pa.PaymentID, pa.Amount, pa.PayType, pa.Description, pa.Purpose, pa.TokenType, pa.TokenOwner, pa.Token
		FROM Payment AS pa (NOLOCK)
		JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.CompanyID = @CompanyID
		AND pa.PayDate <= @PayDate
		AND pa.Status = 1
		AND ((pa.PayType >= 1 AND pa.PayType <= 5 ) Or pa.PayType = 10)
		AND pa.Amount <> 0
		ORDER BY pa.PaymentID
	END
END
ELSE
BEGIN
	SELECT pa.PaymentID, pa.Amount, pa.PayType, pa.Description, pa.Purpose, pa.TokenType, pa.TokenOwner, pa.Token
	FROM Payment AS pa (NOLOCK)
	WHERE pa.Status = 1
	AND pa.PayDate <= @PayDate
	AND ((pa.PayType >= 1 AND pa.PayType <= 5 ) Or pa.PayType = 10)
	AND pa.OwnerType <> 52
	AND pa.Amount <> 0
	ORDER BY pa.PaymentID
END

GO
