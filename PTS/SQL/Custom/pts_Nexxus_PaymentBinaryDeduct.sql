EXEC [dbo].pts_CheckProc 'pts_Nexxus_PaymentBinaryDeduct'
GO

--EXEC pts_Nexxus_PaymentBinaryDeduct 8015, 13946, 3
--select * from SalesOrder order by salesorderid desc

CREATE PROCEDURE [dbo].pts_Nexxus_PaymentBinaryDeduct
   @MemberID int ,
   @PaymentID int ,
   @Amount int ,
   @SaleType int 
AS

SET NOCOUNT ON

DECLARE @ID int, @Now datetime, @Notes nvarchar (500)
SET @Now = GETDATE()

SELECT @Notes = Notes FROM Payment WHERE PaymentID = @PaymentID

-- Check if the Payment is Approved and not "binary" deducted yet
IF CHARINDEX(@Notes,'-') = 0
BEGIN
--	Get the Bonus Volume for the payment
	IF @Amount = 0 EXEC pts_Nexxus_PaymentBV @PaymentID, @Amount OUTPUT

	IF @Amount > 0
	BEGIN
--		BinarySaleID, MemberID, RefID, SaleDate, SaleType, Amount, UserID
		EXEC pts_BinarySale_Add @ID, @MemberID, @PaymentID, @Now, @SaleType, @Amount, 1

--		Mark Payment process for Binary deduction
		UPDATE Payment SET Notes = '-' + Notes WHERE PaymentID = @PaymentID
	END	

END

GO 
