EXEC [dbo].pts_CheckProc 'pts_Nexxus_PaymentBV'
GO

--DECLARE @BV money EXEC pts_Nexxus_PaymentBV 173719, @BV OUTPUT print @BV

CREATE PROCEDURE [dbo].pts_Nexxus_PaymentBV
   @PaymentID int,
   @BV money OUTPUT
AS

SET NOCOUNT ON

DECLARE @Amount money, @Purpose varchar(100), @Retail money, @GiftQty int, @GiftPV money

SET @BV = 0
SET @Purpose = ''
SET @Retail = 0
SET @GiftQty = 0
SET @GiftPV = 0

SELECT @Amount = Amount, @Purpose = Purpose, @Retail = Retail FROM Payment WHERE PaymentID = @PaymentID

--Process product certificates
IF @Purpose = '100'
BEGIN
--	Get Qty and PV from Retail Price (1.25 = 1 qty, 25 pv)
	SET @GiftQty = FLOOR(@Retail)
	SET @GiftPV = (@Retail - @GiftQty) * 100
	SET @BV = @GiftQty * @GiftPV
END

-- Set the Bonus Volume (BV) 
IF @Purpose IN ('200') SET @BV = 2
IF @Purpose IN ('101','201','202','203') SET @BV = 10
IF @Purpose IN ('102','204') SET @BV = 25
IF @Purpose IN ('103','205') SET @BV = 50
IF @Purpose IN ('106','116') SET @BV = 10 * .80
IF @Purpose IN ('107','117') SET @BV = 25 * .80
IF @Purpose IN ('108','118') SET @BV = 50 * .80

IF @Amount < @BV SET @BV = @Amount

GO
