EXEC [dbo].pts_CheckProc 'pts_MemberSales_Company_12_Check'
GO

-- EXEC pts_MemberSales_Company_12_Check 3

CREATE PROCEDURE [dbo].pts_MemberSales_Company_12_Check
   @Months int
AS

SET NOCOUNT ON

DECLARE @Today datetime, @SalesDate datetime, @cnt int, @Count int
SET @Today = GETDATE()

-- **************************************************************************
-- Check for Member Sales totals for the specified number of previous months
-- **************************************************************************
-- Get first day of current month
SET @SalesDate = CAST( CAST(MONTH(@Today) AS CHAR(2)) + '/1/' + CAST(YEAR(@Today) AS CHAR(4)) AS DATETIME )
SET @cnt = 0
WHILE @cnt < @Months
BEGIN
--	-- go back one more month
	SET @SalesDate = DATEADD( m, -1, @SalesDate )
--	-- check for any records for the selected month	
	SELECT TOP 1 @Count = COUNT(ms.MemberSalesID) 
	FROM MemberSales AS ms JOIN Member AS me ON ms.MemberID = me.MemberID
	WHERE me.CompanyID = 12 AND ms.SalesDate = @SalesDate
--	-- if we found no records, calculate Member Sales totals for the selected month
	IF @Count = 0 EXEC pts_MemberSales_Company_12 @SalesDate
	SET @cnt = @cnt + 1
--print CAST(@Count AS VARCHAR(10)) + ' - ' + CAST(@SalesDate AS VARCHAR(20))
END

GO