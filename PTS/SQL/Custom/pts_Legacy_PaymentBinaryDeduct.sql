EXEC [dbo].pts_CheckProc 'pts_Legacy_PaymentBinaryDeduct'
GO

--EXEC pts_Legacy_PaymentBinaryDeduct 8015, 13946, 3
--select * from SalesOrder order by salesorderid desc

CREATE PROCEDURE [dbo].pts_Legacy_PaymentBinaryDeduct
   @MemberID int ,
   @SalesOrderID int ,
   @SaleType int 
AS

SET NOCOUNT ON

DECLARE @Amount money, @ID int, @Now datetime
SET @Now = GETDATE()

-- Get the product points
SELECT @Amount = SUM(si.Quantity * pr.BV) 
FROM SalesItem AS si 
JOIN Product AS pr ON si.ProductID = pr.ProductID
WHERE si.SalesOrderID = @SalesOrderID

--  BinarySaleID, MemberID, RefID, SaleDate, SaleType, Amount, UserID
IF @Amount > 0 EXEC pts_BinarySale_Add @ID, @MemberID, @SalesOrderID, @Now, @SaleType, @Amount, 1

-- Mark Payment process for Binary deduction
UPDATE Payment SET Notes = '-' + Notes WHERE OwnerType = 52 and OwnerID = @SalesOrderID

GO 
