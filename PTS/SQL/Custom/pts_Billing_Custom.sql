EXEC [dbo].pts_CheckProc 'pts_Billing_Custom'
GO

--EXEC pts_Billing_Custom 5, 1
--Update Billing SET Token=0, TokenType=0, Verified=0 where BillingID = 619

CREATE PROCEDURE [dbo].pts_Billing_Custom
   @CompanyID int ,
   @Token int
AS

SET NOCOUNT ON
DECLARE @Process int
SET @Process = @Token

-- get all billing records without tokens
IF @Process = 1
BEGIN
	SELECT   bi.BillingID, 
         bi.CountryID, 
         bi.TokenType, 
         bi.TokenOwner, 
         bi.Token, 
         bi.Verified, 
         bi.BillingName, 
         bi.Street1, 
         bi.Street2, 
         bi.City, 
         bi.State, 
         bi.Zip, 
         bi.PayType, 
         bi.CommType, 
         bi.CardType, 
         bi.CardNumber, 
         bi.CardMo, 
         bi.CardYr, 
         bi.CardName, 
         bi.CardCode, 
         bi.CheckBank, 
         bi.CheckRoute, 
         bi.CheckAccount, 
         bi.CheckAcctType, 
         bi.CheckNumber, 
         bi.CheckName
	FROM Billing AS bi
	JOIN Member AS me ON bi.BillingID = me.BillingID
	WHERE me.CompanyID = @CompanyID AND me.GroupID <> 100 AND bi.Token = 0
END

GO