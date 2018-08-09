EXEC [dbo].pts_CheckProc 'pts_Nexxus_PaymentBinary'
GO

--EXEC pts_Nexxus_PaymentBinary 39506, 170202, 50
--select * from SalesOrder order by salesorderid desc

--EXEC pts_Nexxus_PaymentBinary 38914, 170245, 2
--EXEC pts_Nexxus_PaymentBinary 38914, 170284, 2
--EXEC pts_Nexxus_PaymentBinary 38914, 170279, 2

--select * from Payment where companyid = 21 and Amount = 5.50


CREATE PROCEDURE [dbo].pts_Nexxus_PaymentBinary
   @MemberID int ,
   @PaymentID int ,
   @Amount money
AS

SET NOCOUNT ON

DECLARE @ID int, @Now datetime, @Status int, @Notes nvarchar (500)
SET @Now = GETDATE()

SELECT @Status = Status, @Notes = Notes FROM Payment WHERE PaymentID = @PaymentID

-- Check if the Payment is Approved and not "binary" processed yet
IF @Status = 3 AND CHARINDEX(@Notes,'B*') = 0
BEGIN
--	Get the Bonus Volume for the payment
	IF @Amount = 0 EXEC pts_Nexxus_PaymentBV @PaymentID, @Amount OUTPUT

	IF @Amount > 0
	BEGIN
--		BinarySaleID, MemberID, RefID, SaleDate, SaleType, Amount, UserID
		EXEC pts_BinarySale_Add @ID, @MemberID, @PaymentID, @Now, 1, @Amount, 1

--		Mark Payment process for Binary
		UPDATE Payment SET Notes = 'B*' + Notes WHERE PaymentID = @PaymentID
	END	

END

GO 

