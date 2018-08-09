EXEC [dbo].pts_CheckProc 'pts_Commission_Company_7d'
GO

--DECLARE @Cnt int EXEC pts_Commission_Company_7d 0, @Cnt OUTPUT print 'Count: ' + CAST(@Cnt AS VARCHAR(10))

--UPDATE BinarySale SET Status = 1 WHERE Status <> 1

CREATE PROCEDURE [dbo].pts_Commission_Company_7d
   @ToDate datetime ,
   @Count int OUTPUT 
AS
DECLARE @CompanyID int, @Now datetime, @Today datetime, @Expired datetime, @ID int
DECLARE @Cnt1 int, @Cnt2 int, @Cycle int, @Title int, @Cap money, @Accum money
DECLARE @MemberID int, @BinarySaleID int, @SaleID int, @Name varchar(100), @Desc varchar(500)

SET @CompanyID = 7
SET @Count = 0
SET @Now = GETDATE()
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @Expired = DATEADD( month, -6, @Today )
IF @ToDate = 0 SET @ToDate = @Today

-- Check for Expired Binary Sales (status=4)
UPDATE BinarySale SET Status = 4 WHERE Status = 1 AND StatusDate < @Expired 

-- Get All qualified members with at least 2 new sales in their 2-BY Infinity weak leg
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT me.MemberID, me.Title FROM Member AS me
WHERE  CompanyID = @CompanyID AND Qualify = 2 AND Status = 1 AND Title >= 1 AND Title <= 4
AND 2 <= ( SELECT COUNT(*) FROM BinarySale WHERE MemberID = me.MemberID AND Pos = CASE me.Pos WHEN 2 Then 1 ELSE 2 END AND Status = 1 AND StatusDate <= @ToDate )

-- Process Each Member
OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title
WHILE @@FETCH_STATUS = 0
BEGIN
--	-- get the count on the left and right legs
	SELECT @Cnt1 = COUNT(*) FROM BinarySale WHERE MemberID = @MemberID AND Pos = 1 AND Status = 1 AND StatusDate <= @ToDate
	SELECT @Cnt2 = COUNT(*) FROM BinarySale WHERE MemberID = @MemberID AND Pos = 2 AND Status = 1 AND StatusDate <= @ToDate
	
	IF @Cnt1 > @Cnt2 SET @Cycle = @Cnt2/2 ELSE SET @Cycle = @Cnt1/2

--print 'Member: ' + CAST(@MemberID AS VARCHAR(10)) + ' ' + CAST(@Cnt1 AS VARCHAR(10)) + ' ' + CAST(@Cnt2 AS VARCHAR(10))

	WHILE @Cycle > 0
	BEGIN		
--		-- Get the Member's max bonuses based on their title
		SET @Accum = 0
		SET @Cap = 0
		IF @Title = 1 SET @Cap = 2100
		IF @Title = 2 SET @Cap = 4900
		IF @Title = 3 SET @Cap = 8400
		IF @Title = 4 SET @Cap = 14000
	
--		-- Create a $50 bonus for each 2 sales on the left and each 2 sales on the right
		IF (@Accum + 50) <= @Cap
		BEGIN
			SET @Desc = ''
--			-- Get 1st binary sale for the bonus and mark it paid
			SELECT TOP 1 @BinarySaleID = bs.BinarySaleID, @Desc = @Desc + CAST(me.MemberID AS VARCHAR(10)) + ':' + me.NameFirst + ' ' + me.NameLast + ' '
			FROM BinarySale AS bs JOIN Member AS me ON bs.SaleID = me.MemberID
			WHERE bs.MemberID = @MemberID AND bs.Pos = 1 AND bs.Status = 1 AND bs.StatusDate <= @ToDate ORDER BY bs.BinarySaleID
--			-- Mark 1st binary sale for the bonus paid
			UPDATE BinarySale SET Status = 2 WHERE BinarySaleID = @BinarySaleID

--			-- Get 2nd binary sale for the bonus and mark it paid
			SELECT TOP 1 @BinarySaleID = bs.BinarySaleID, @Desc = @Desc + CAST(me.MemberID AS VARCHAR(10)) + ':' + me.NameFirst + ' ' + me.NameLast + ' '
			FROM BinarySale AS bs JOIN Member AS me ON bs.SaleID = me.MemberID
			WHERE bs.MemberID = @MemberID AND bs.Pos = 1 AND bs.Status = 1 AND bs.StatusDate <= @ToDate ORDER BY bs.BinarySaleID
--			-- Mark 2nd binary sale for the bonus paid
			UPDATE BinarySale SET Status = 2 WHERE BinarySaleID = @BinarySaleID

--			-- Get 1st binary sale for the bonus and mark it paid
			SELECT TOP 1 @BinarySaleID = bs.BinarySaleID, @Desc = @Desc + CAST(me.MemberID AS VARCHAR(10)) + ':' + me.NameFirst + ' ' + me.NameLast + ' '
			FROM BinarySale AS bs JOIN Member AS me ON bs.SaleID = me.MemberID
			WHERE bs.MemberID = @MemberID AND bs.Pos = 2 AND bs.Status = 1 AND bs.StatusDate <= @ToDate ORDER BY bs.BinarySaleID
--			-- Mark 1st binary sale for the bonus paid
			UPDATE BinarySale SET Status = 2 WHERE BinarySaleID = @BinarySaleID

--			-- Get 2nd binary sale for the bonus and mark it paid
			SELECT TOP 1 @BinarySaleID = bs.BinarySaleID, @Desc = @Desc + CAST(me.MemberID AS VARCHAR(10)) + ':' + me.NameFirst + ' ' + me.NameLast + ' '
			FROM BinarySale AS bs JOIN Member AS me ON bs.SaleID = me.MemberID
			WHERE bs.MemberID = @MemberID AND bs.Pos = 2 AND bs.Status = 1 AND bs.StatusDate <= @ToDate ORDER BY bs.BinarySaleID
--			-- Mark 2nd binary sale for the bonus paid
			UPDATE BinarySale SET Status = 2 WHERE BinarySaleID = @BinarySaleID
				
--			-- Add 2-By Infinity Bonus 
			IF Len(@Desc) > 100 SET @Desc = Left(@Desc,100)
--print 'Cycle: ' + CAST(@Cycle AS VARCHAR(10)) + ' ' + @Desc
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @ID OUTPUT, @CompanyID, 4, @MemberID, 0, 0, @Now, 1, 7, 50, 50, 0, @Desc, '', 1
			SET @Count = @Count + 1
		END
		ELSE
		BEGIN
--			-- Mark this cycle OverLimit (Status=3)
			SELECT TOP 1 BinarySaleID FROM BinarySale WHERE MemberID = @MemberID AND Pos = 1 AND Status = 1 AND StatusDate <= @ToDate ORDER BY BinarySaleID
			UPDATE BinarySale SET Status = 3 WHERE BinarySaleID = @BinarySaleID
			SELECT TOP 1 BinarySaleID FROM BinarySale WHERE MemberID = @MemberID AND Pos = 1 AND Status = 1 AND StatusDate <= @ToDate ORDER BY BinarySaleID
			UPDATE BinarySale SET Status = 3 WHERE BinarySaleID = @BinarySaleID
			SELECT TOP 1 BinarySaleID FROM BinarySale WHERE MemberID = @MemberID AND Pos = 2 AND Status = 1 AND StatusDate <= @ToDate ORDER BY BinarySaleID
			UPDATE BinarySale SET Status = 3 WHERE BinarySaleID = @BinarySaleID
			SELECT TOP 1 BinarySaleID FROM BinarySale WHERE MemberID = @MemberID AND Pos = 2 AND Status = 1 AND StatusDate <= @ToDate ORDER BY BinarySaleID
			UPDATE BinarySale SET Status = 3 WHERE BinarySaleID = @BinarySaleID
		END
		SET @Cycle = @Cycle - 1
	END
		
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

GO
