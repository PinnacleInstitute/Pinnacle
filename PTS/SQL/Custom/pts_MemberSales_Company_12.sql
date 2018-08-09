EXEC [dbo].pts_CheckProc 'pts_MemberSales_Company_12'
GO

CREATE PROCEDURE [dbo].pts_MemberSales_Company_12
   @SalesDate datetime 
AS
-- *************************************************************************************
-- Create monthly sales summary record for each member's personal and group commissions
-- *************************************************************************************

-- Get date range for month to process
DECLARE @FromDate AS DateTime, @ToDate AS DateTime
SET @FromDate = CAST( CAST(MONTH(@SalesDate) AS CHAR(2)) + '/1/' + CAST(YEAR(@SalesDate) AS CHAR(4)) AS DATETIME )
SET @ToDate = DATEADD( d, -1, DATEADD( m, 1, @FromDate ) )

-- Create a record for each member that has commissions for orders in the specified month
INSERT INTO MemberSales (MemberID, SalesDate, PV, GV ) 
	SELECT co.OwnerID, @FromDate, SUM(co.Amount), SUM(co.Amount)
	FROM Commission AS co 
	JOIN SalesOrder AS so ON co.RefID = so.SalesOrderID
	WHERE co.CompanyID = 12
	AND   co.CommType <= 2
	AND   so.OrderDate >= @FromDate
	AND   so.OrderDate < @ToDate 
	GROUP BY co.OwnerID

-- calculate group volumes (add membersales record if neccessary)
DECLARE @MemberID int, @PV money, @SponsorID int, @MemberSalesID int 
DECLARE MemberSales_Cursor CURSOR LOCAL STATIC FOR 
SELECT ms.MemberID, ms.PV FROM MemberSales AS ms JOIN Member AS me ON ms.MemberID = me.MemberID
WHERE me.CompanyID = 12 AND ms.SalesDate = @FromDate

OPEN MemberSales_Cursor
FETCH NEXT FROM MemberSales_Cursor INTO @MemberID, @PV
WHILE @@FETCH_STATUS = 0
BEGIN
--	-- Walk up the sponsor line and accumulate the group volume (GV)
	WHILE @MemberID > 0
	BEGIN
--		-- Get the sponsor
		SELECT @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
		IF @SponsorID > 0
		BEGIN
--			-- Get the sponsor's membersales record
			SELECT @MemberSalesID = ISNULL(MemberSalesID,0) FROM MemberSales
			WHERE MemberID = @SponsorID AND SalesDate = @FromDate

--			-- If it doesn't exist add it, otherwise update it with the accumulated GV
			IF @MemberSalesID = 0
				INSERT INTO MemberSales (MemberID, SalesDate, GV ) VALUES ( @SponsorID, @FromDate, @PV )
			ELSE
				UPDATE MemberSales SET GV = GV + @PV WHERE MemberSalesID = @MemberSalesID
		END
--		-- Set the memberID to get the next upline sponsor
		SET @MemberID = @SponsorID
	END	
	FETCH NEXT FROM MemberSales_Cursor INTO @MemberID, @PV
END
CLOSE MemberSales_Cursor
DEALLOCATE MemberSales_Cursor

-- Initialize Member.BV, QV
UPDATE Member SET BV = 0, QV = 0 WHERE CompanyID = 12 AND (BV > 0 OR QV > 0)

-- Update Member.BV, QV with MemberSales.PV, GV
UPDATE me SET BV = ms.PV, QV = ms.GV
FROM Member AS me
JOIN MemberSales AS ms ON me.MemberID = ms.MemberID AND ms.SalesDate = @FromDate
WHERE me.CompanyID = 12

GO
