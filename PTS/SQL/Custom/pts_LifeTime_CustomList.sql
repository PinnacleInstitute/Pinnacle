EXEC [dbo].pts_CheckProc 'pts_LifeTime_CustomList'
GO

-- EXEC pts_LifeTime_CustomList 5, 0, 0, 0

CREATE PROCEDURE [dbo].pts_LifeTime_CustomList
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

DECLARE @Today datetime, @ToDate datetime

SET @Today = dbo.wtfn_DateOnly(GETDATE())

-- List all payments to process
IF @Status = 1
BEGIN
	SELECT pa.PaymentID AS 'LifeTimeID', CAST(pa.PaymentID AS VARCHAR(10)) + '|' + CAST(pa.PayType AS VARCHAR(10)) + '|' + CAST(pa.Amount AS VARCHAR(10)) + '|' + me.Reference + '|' + CAST(pa.TokenType AS VARCHAR(10)) + '|' + CAST(pa.Token AS VARCHAR(15)) AS 'Result'
	FROM Payment AS pa (NOLOCK)
	JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
	WHERE me.CompanyID = 5 AND pa.Status = 1 AND pa.Amount <> 0
	AND pa.PayType >= 1 AND pa.PayType <= 4
	ORDER BY pa.PaymentID
END

GO

