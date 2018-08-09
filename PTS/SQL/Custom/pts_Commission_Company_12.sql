EXEC [dbo].pts_CheckProc 'pts_Commission_Company_12'
GO

--DECLARE @Count int
--EXEC pts_Commission_Company_12 1, '1/1/10',  '5/1/10', @Count OUTPUT
--PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_12
   @CommType int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

DECLARE @Rate money, @Bonus money, @GV money, @TotalOrders money, @TotalGV money
DECLARE @SalesOrderID int, @MemberID int, @Amount money, @LastRate money, @cType int 
DECLARE @Title int, @Today datetime, @SponsorID int, @ID int, @Desc varchar(100)

SET @Count = 0
SET @Today = GETDATE()

-- Calculate sales commissions for sales orders
IF @CommType = 1
BEGIN
-- 	-- Get all uncommisioned orders to process
	DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
	SELECT SalesOrderID, MemberID, Amount FROM SalesOrder
	WHERE CompanyID = 12 AND Status = 3 AND CommDate = 0
	AND OrderDate >= @FromDate AND OrderDate < @ToDate 
	
	OPEN Member_Cursor
	FETCH NEXT FROM Member_Cursor INTO @SalesOrderID, @MemberID, @Amount
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @LastRate = 0
		SET @Title = 0
		SET @cType = 1
--		-- Create commissions for agent and upline sponsors
		WHILE @MemberID > 0 AND @Title <= 7 AND @Amount > 0
		BEGIN
--			-- Get the sponsor
			SELECT @Title = Title, @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID

--			-- Calculate commission rate
			SET @Rate = 
			CASE @Title
				WHEN 1 THEN 0.020
				WHEN 2 THEN 0.080
				WHEN 3 THEN 0.085
				WHEN 4 THEN 0.090
				WHEN 5 THEN 0.095
				WHEN 6 THEN 0.100
				WHEN 7 THEN 0.120
				ELSE 0.000
			END

			IF @Rate > @LastRate
			BEGIN
				SET @Rate = @Rate - @LastRate
				SET @LastRate = @Rate
				SET @Bonus = @Amount * @Rate
				SET @Desc = CAST( @Amount AS VARCHAR(20) ) + ' * ' + CAST( @Rate AS VARCHAR(10) )
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, 12, 4, @MemberID, 0, @SalesOrderID, @Today, 0, @cType, @Bonus, @Bonus, 0, @Desc, '', 1
				SET @Count = @Count + 1
				SET @cType = 2
			END
--			-- Set the memberID to get the next upline sponsor
			SET @MemberID = @SponsorID
		END
--		-- Update Sales Order commissioned date
		UPDATE SalesOrder SET CommDate = @Today WHERE SalesOrderID = @SalesOrderID 
			
		FETCH NEXT FROM Member_Cursor INTO @SalesOrderID, @MemberID, @Amount
	END
	CLOSE Member_Cursor
	DEALLOCATE Member_Cursor
END

-- Calculate pool bonuses for EMD and SEMD
IF @CommType = 3
BEGIN
-- 	-- ********************************************************
-- 	-- Check for Member Sales totals for previous 1 month
-- 	-- the bonus calculation uses the past monthly sales totals 
-- 	-- ********************************************************
	EXEC pts_MemberSales_Company_12_Check 1

-- 	-- Calculate total amount for orders in the date range
	SELECT @TotalOrders = SUM(Amount) FROM SalesOrder
	WHERE CompanyID = 12 AND Status = 3 AND CommDate > 0
	AND OrderDate >= @FromDate AND OrderDate < @ToDate 

--	-- *****************************
--	-- Calculate EMD Pool Bonuses --
--	-- *****************************

--	-- calculate EMD pool amount
	SET @Amount = @TotalOrders * .005

--	-- Calculate total group commissions earned by all EMDs
	SELECT @TotalGV = SUM(QV) FROM Member 
	WHERE CompanyID = 12 AND Title = 5 AND QV > 0

-- 	-- Calculate percentage of each EMD group commissions of all EMDs
	DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID, QV FROM Member 
	WHERE CompanyID = 12 AND Title = 5 AND QV > 0

	OPEN Member_Cursor
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @GV
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		-- Calculate percentage
		SET @Rate = @GV / @TotalGV
		SET @Bonus = ROUND(@Amount * @Rate,2)
		SET @Desc = CAST( @Amount AS VARCHAR(20) ) + ' * ' + CAST( @Rate AS VARCHAR(10) )
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, 12, 4, @MemberID, 0, 0, @Today, 0, 3, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
			
		FETCH NEXT FROM Member_Cursor INTO @MemberID, @GV
	END
	CLOSE Member_Cursor
	DEALLOCATE Member_Cursor


--	-- ******************************
--	-- Calculate SEMD Pool Bonuses --
--	-- ******************************

--	-- calculate SEMD pool amount
	SET @Amount = @TotalOrders * .015

--	-- Calculate total group commissions earned by all SEMDs and FMOs
	SELECT @TotalGV = SUM(QV) FROM Member 
	WHERE CompanyID = 12 AND Title >= 6 AND QV > 0

-- 	-- Calculate percentage of each EMD group commissions of all SEMDs and FMOs
	DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID, QV FROM Member 
	WHERE CompanyID = 12 AND Title >= 6 AND QV > 0

	OPEN Member_Cursor
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @GV
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		-- Calculate percentage
		SET @Rate = @GV / @TotalGV
		SET @Bonus = ROUND(@Amount * @Rate,2)
		SET @Desc = CAST( @Amount AS VARCHAR(20) ) + ' * ' + CAST( @Rate AS VARCHAR(10) )
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, 12, 4, @MemberID, 0, 0, @Today, 0, 4, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
			
		FETCH NEXT FROM Member_Cursor INTO @MemberID, @GV
	END
	CLOSE Member_Cursor
	DEALLOCATE Member_Cursor
END

GO
