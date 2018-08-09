EXEC [dbo].pts_CheckProc 'pts_Member_AddCustom_7'
GO

CREATE PROCEDURE [dbo].pts_Member_AddCustom_7
   @MemberID int
AS

DECLARE @Level int, @Title int, @Price money, @BillingID int, @ID int, @PaidDate datetime
DECLARE @PayType int, @tmpDescription varchar(200), @BillingInfo varchar(200) 

--SELECT @Level = [Level], @Title = Title, @BillingID = BillingID FROM Member WHERE MemberID = @MemberID

--IF @Level = 1
--BEGIN
----	Create one-time Payment for new Members
--	SET @PaidDate = dbo.wtfn_DateOnly(GETDATE())
--	SET @Price = 75.00
--
--	SET @PayType = 0
--	SET @BillingInfo = ''
--	SELECT @PayType = 
--		CASE PayType
--		WHEN 1 THEN CardType 
--		WHEN 2 THEN 5
--		WHEN 3 THEN 7
--		ELSE 0
--		END, 
--			@BillingInfo = 
--		CASE PayType
--		WHEN 1 THEN CAST(CardType AS varchar(10)) + '; ' + CardNumber + '; ' + CAST(CardMo AS varchar(10)) + '/' + CAST(CardYr AS varchar(10)) + '; ' + CardCode + '; ' + CardName + '; ' + Street1 + '; ' + Street2 + '; ' + City + '; ' + State + '; ' + Zip + '; ' + co.Code + '; ' + Token
--		WHEN 2 THEN CheckBank + '; ' + CheckRoute + '; ' + CheckAccount + '; ' + CheckNumber + '; ' + CheckName + '; ' + CAST(CheckAcctType AS varchar(2))
--		WHEN 4 THEN CAST(CardType AS varchar(10)) + '; ' + CardName
--		ELSE ''
--		END
--	FROM Billing AS bi
--	LEFT OUTER JOIN Country AS co ON bi.CountryID = co.CountryID
--	WHERE BillingID = @BillingID
--
--	IF @PayType < 7 SET @tmpDescription = 'Charged:[' + @BillingInfo + ']' ELSE SET @tmpDescription = ''
--
--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType,TokenOwner,Token,UserID
----EXEC pts_Payment_Add @ID, 0, 4, @MemberID, 0, 0, 0, @PaidDate, 0, @PayType, 
----	     @Price, @Price, 0, 0, 0, @tmpDescription, '', 1, '', '', 1, 0, 0, 0, 0, 1
---END

GO
