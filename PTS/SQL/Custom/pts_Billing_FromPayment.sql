EXEC [dbo].pts_CheckProc 'pts_Billing_FromPayment'
GO

--DECLARE @BillingID int EXEC pts_Billing_FromPayment 24554, @BillingID output PRINT @BillingID

CREATE PROCEDURE [dbo].pts_Billing_FromPayment
   @PaymentID int ,
   @BillingID int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Desc nvarchar(200), @pos int, @cnt int
DECLARE @P0 nvarchar(100), @P1 nvarchar(100), @P2 nvarchar(100), @P3 nvarchar(100), @P4 nvarchar(100), @P5 nvarchar(100)
DECLARE @P6 nvarchar(100), @P7 nvarchar(100), @P8 nvarchar(100), @P9 nvarchar(100), @P10 nvarchar(100), @Token nvarchar(100)
DECLARE @CountryID int, @mo int, @yr int, @CardType int, @AcctType int

SET @BillingID = 0
SET @cnt = 0

SELECT @Desc = Description FROM Payment WHERE PaymentID = @PaymentID
--PRINT @Desc
-- Get Payment info from description in brackets
SET @pos = CHARINDEX( 'Charged:[', @Desc ) 
IF @pos > 0
BEGIN
	SET @Desc = SUBSTRING( @Desc, @pos+9, 200 )
	SET @pos = CHARINDEX( ']', @Desc ) 
	IF @pos > 0 SET @Desc = SUBSTRING( @Desc, 1, @pos-1 )
END 

-- If we found the payment info in brackets, then extract all the ; delimited values
IF @pos > 0
BEGIN
	WHILE @Desc != ''
	BEGIN
		SET @pos = CHARINDEX( ';', @Desc ) 
		IF @pos > 0
		BEGIN
			SET @Token = LTRIM(SUBSTRING( @Desc, 1, @pos-1 ))
			SET @Desc = SUBSTRING( @Desc, @pos+1, 200 )
		END
		ELSE
		BEGIN
			SET @Token = LTRIM(@Desc)
			SET @Desc = ''
		END
		IF @cnt = 0 SET @P0 = @Token
		IF @cnt = 1 SET @P1 = @Token
		IF @cnt = 2 SET @P2 = @Token
		IF @cnt = 3 SET @P3 = @Token
		IF @cnt = 4 SET @P4 = @Token
		IF @cnt = 5 SET @P5 = @Token
		IF @cnt = 6 SET @P6 = @Token
		IF @cnt = 7 SET @P7 = @Token
		IF @cnt = 8 SET @P8 = @Token
		IF @cnt = 9 SET @P9 = @Token
		IF @cnt = 10 SET @P10 = @Token
		SET @cnt = @cnt + 1
--PRINT @Token
	END	
END	

-- Test for a numeric first token for credit cards and wallets
IF @cnt > 0
BEGIN
	IF ISNUMERIC( @P0 ) = 1
	BEGIN
--		Process Cerdit Cards
		SET @CardType = CAST( @P0 AS int )
		IF @CardType < 10 
		BEGIN
--			Make sure we have 11 tokens	
			IF @cnt >= 11
			BEGIN
				SET @CountryID = 0	
				SELECT @CountryID = CountryID FROM Country WHERE Code = @P10
--				Get Card month and year
				SET @pos = CHARINDEX( '/', @P2 ) 
				IF @pos > 0
				BEGIN
					SET @mo = CAST( SUBSTRING( @P2, 1, @pos-1 ) AS int )
					SET @yr = CAST( SUBSTRING( @P2, @pos+1, 10 ) AS int )
				END
--				@BillingID,@CountryID,@TokenType,@TokenOwner,@Token,@Verified,@BillingName,@Street1,@Street2,@City,@State,@Zip,
--				@PayType,@CommType,@CardType,@CardNumber,@CardMo,@CardYr,@CardName,@CardCode,
--				@CheckBank,@CheckRoute,@CheckAccount,@CheckAcctType,@CheckNumber,@CheckName,@UpdatedDate,@UserID
				EXEC pts_Billing_Add @BillingID OUTPUT, @CountryID, 0, 0, 0, 0, 'First Last', @P5, @P6, @P7, @P8, @P9, 
					1, 0, @CardType, @P1, @mo, @yr, @P4, @P3, 
					'', '', '', 0, '', '', 0, 1 
			END	
		END
		ELSE
		BEGIN
--			Process Wallet
--			Make sure we have 2 tokens	
			IF @cnt >= 2
			BEGIN	
--				@BillingID,@CountryID,@TokenType,@TokenOwner,@Token,@Verified,@BillingName,@Street1,@Street2,@City,@State,@Zip,
--				@PayType,@CommType,@CardType,@CardNumber,@CardMo,@CardYr,@CardName,@CardCode,
--				@CheckBank,@CheckRoute,@CheckAccount,@CheckAcctType,@CheckNumber,@CheckName,@UpdatedDate,@UserID
				EXEC pts_Billing_Add @BillingID OUTPUT, 0, 0, 0, 0, 0, '', '', '', '', '', '', 
					4, 0, @CardType, '', 0, 0, @P1, '', 
					'', '', '', 0, '', '', 0, 1 
			END
		END
	END
	ELSE
	BEGIN
--		Process Electronic Checks
--		Make sure we have 5 tokens	
		IF @cnt >= 5
		BEGIN	
			SET @AcctType = CAST( @P5 AS int )
--			@BillingID,@CountryID,@TokenType,@TokenOwner,@Token,@Verified,@BillingName,@Street1,@Street2,@City,@State,@Zip,
--			@PayType,@CommType,@CardType,@CardNumber,@CardMo,@CardYr,@CardName,@CardCode,
--			@CheckBank,@CheckRoute,@CheckAccount,@CheckAcctType,@CheckNumber,@CheckName,@UpdatedDate,@UserID
			EXEC pts_Billing_Add @BillingID OUTPUT, 0, 0, 0, 0, 0, '', '', '', '', '', '', 
				2, 0, 0, '', 0, 0, '', '', 
				@P0, @P1, @P2, @AcctType, @P3, @P4, 0, 1 
		END
	END
END

GO