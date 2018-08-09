-- ********************************************************************************************************
-- IMPORT SALES ORDERS
-- 1. INSERT Sales Orders  
-- 2. INSERT Sales Items
-- 3. Set Sales Order MemberID
-- 4. Set Sales Item - SalesOrderID
-- 5. Set Sales Order ProductID
-- 6. Update Points for Juice and EFL
-- 7. Clear temp fields
-- ********************************************************************************************************

-- ********************************************************************************************************
-- Set Sales Order MemberID
-- ********************************************************************************************************
UPDATE so
SET so.MemberID = me.MemberID
FROM SalesOrder AS so
JOIN Member as me ON so.AffiliateID = me.Reference and me.companyid=582
WHERE so.SalesOrderID > 99999

-- ********************************************************************************************************
-- Set Sales Item - SalesOrderID
-- ********************************************************************************************************
UPDATE si
SET si.SalesOrderID = so.SalesOrderID 
FROM SalesItem AS si
JOIN SalesOrder as so ON si.SalesOrderID = so.PromotionID and so.companyid=582
WHERE si.SalesItemID > 99999

-- ********************************************************************************************************
-- Set Sales Order ProductID
-- ********************************************************************************************************
UPDATE si
SET si.ProductID = pr.ProductID 
FROM SalesItem AS si
JOIN Product as pr ON si.Locks = pr.Code
WHERE si.SalesItemID > 99999

-- ********************************************************************************************************
-- Update Points for EFL
-- ********************************************************************************************************
DECLARE @SalesOrderID int, @BV money

DECLARE SalesOrder_Cursor CURSOR LOCAL STATIC FOR 
SELECT SalesOrderID, SUM(Quantity) * 3
FROM SalesItem WHERE SalesOrderID > 99999 AND Locks = 69600
GROUP BY SalesOrderID
OPEN SalesOrder_Cursor
FETCH NEXT FROM SalesOrder_Cursor INTO @SalesOrderID, @BV
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE SalesOrder SET BV = BV + @BV
	FETCH NEXT FROM SalesOrder_Cursor INTO @SalesOrderID
END
CLOSE SalesOrder_Cursor
DEALLOCATE SalesOrder_Cursor

-- ********************************************************************************************************
-- Update Points for Juice
-- ********************************************************************************************************
DECLARE SalesOrder_Cursor CURSOR LOCAL STATIC FOR 
SELECT SalesOrderID, SUM(Quantity) * 15
FROM SalesItem WHERE SalesOrderID > 99999 AND Locks = 60606
GROUP BY SalesOrderID
OPEN SalesOrder_Cursor
FETCH NEXT FROM SalesOrder_Cursor INTO @SalesOrderID, @BV
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE SalesOrder SET BV = BV + @BV
	FETCH NEXT FROM SalesOrder_Cursor INTO @SalesOrderID
END
CLOSE SalesOrder_Cursor
DEALLOCATE SalesOrder_Cursor

-- ********************************************************************************************************
-- Clear temp fields
-- ********************************************************************************************************
UPDATE SalesOrder SET AffiliateID = 0, PromotionID = 0 WHERE SalesOrderID > 99999
UPDATE SalesItem SET Locks = 0 WHERE SalesItemID > 99999

