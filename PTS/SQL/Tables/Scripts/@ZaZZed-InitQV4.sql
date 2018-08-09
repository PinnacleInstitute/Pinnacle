-- *******************************************************************
-- Initialize QV4 from BinarySales records 
-- *******************************************************************
DECLARE @CompanyID int, @MemberID int, @SaleType int, @Amount money
SET @CompanyID = 9

--	Clear QV4
UPDATE Member SET QV4 = 0 WHERE CompanyID = @CompanyID AND QV4 > 0

--	Process all BinarySales starting with the first entered
DECLARE BinarySale_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, SaleType, Amount
FROM BinarySale 
ORDER BY SaleDate

OPEN BinarySale_cursor
FETCH NEXT FROM BinarySale_cursor INTO @MemberID, @SaleType, @Amount
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_BinarySale_AddCustom @MemberID, @SaleType, @Amount
	
	FETCH NEXT FROM BinarySale_cursor INTO  @MemberID, @SaleType, @Amount
END
CLOSE BinarySale_cursor
DEALLOCATE BinarySale_cursor

GO