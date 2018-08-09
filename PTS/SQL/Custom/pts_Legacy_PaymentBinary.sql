EXEC [dbo].pts_CheckProc 'pts_Legacy_PaymentBinary'
GO

--EXEC pts_Legacy_PaymentBinary 7164, 13861
--select * from SalesOrder order by salesorderid desc

CREATE PROCEDURE [dbo].pts_Legacy_PaymentBinary
   @MemberID int ,
   @SalesOrderID int 
AS

SET NOCOUNT ON

DECLARE @Amount money, @ID int, @Now datetime
SET @Now = GETDATE()

-- Get the product points
SELECT @Amount = SUM(si.Quantity * pr.BV) 
FROM SalesItem AS si 
JOIN Product AS pr ON si.ProductID = pr.ProductID
WHERE si.SalesOrderID = @SalesOrderID

--IF @Amount < 0
--BEGIN
----	Get the points from the sales item
--	SELECT @Amount = SUM(si.Quantity * si.BV) 
--	FROM SalesItem AS si 
--	JOIN Product AS pr ON si.ProductID = pr.ProductID
--	WHERE si.SalesOrderID = @SalesOrderID
--END

--  BinarySaleID, MemberID, RefID, SaleDate, SaleType, Amount, UserID
IF @Amount > 0 EXEC pts_BinarySale_Add @ID, @MemberID, @SalesOrderID, @Now, 1, @Amount, 1

-- Mark Payment process for Binary
UPDATE Payment SET Notes = 'B*' + Notes WHERE OwnerType = 52 and OwnerID = @SalesOrderID

GO 

