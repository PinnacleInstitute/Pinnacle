EXEC [dbo].pts_CheckProc 'pts_CIS_NeweWallets'
GO

--DECLARE @Result varchar(1000) CIS pts_CIS_NeweWallets @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_CIS_NeweWallets
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @cnt int
SET @CompanyID = 15
SET @Result = '0'

SELECT @cnt = COUNT(bi.BillingID)
FROM Billing AS bi
JOIN Member AS me ON bi.BillingID = me.PayID
WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Level = 1
AND bi.CardType = 11 AND bi.CardName = ''

SET @Result = CAST(@cnt AS VARCHAR(10))

UPDATE Billing SET CardName = au.Logon
FROM Billing AS bi
JOIN Member AS me ON bi.BillingID = me.PayID
JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Level = 1
AND bi.CardType = 11 AND bi.CardName = ''

GO
