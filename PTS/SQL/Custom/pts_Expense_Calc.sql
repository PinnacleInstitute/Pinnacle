EXEC [dbo].pts_CheckProc 'pts_Expense_Calc'
GO

CREATE PROCEDURE [dbo].pts_Expense_Calc
   @ExpenseID int,
   @Year int,
   @ExpType int,
   @Amount money,
   @MemberID int,
   @TotalMiles int,
   @MilesStart int,
   @MilesEnd int,
   @TaxType int
AS

SET NOCOUNT ON

DECLARE @Rate money  

-- Direct Expense, set the total equal to the amount entered
IF @TaxType = 0 
BEGIN
	UPDATE Expense SET Total = Amount WHERE ExpenseID = @ExpenseID	
END		

-- Apply the tax rate specified in the Expense Type
IF @TaxType > 0 
BEGIN
	SET @Rate = 0
	SELECT @Rate = ISNULL(Rate,0) FROM TaxRate WHERE Year = @Year AND TaxType = @TaxType

--	-- If Mileage, calculate mileage with the rate
	IF @ExpType = 1
	BEGIN
		IF @MilesEnd = 0 
			SET @TotalMiles = 0
		ELSE
			SET @TotalMiles = @MilesEnd - @MilesStart

		IF @Rate <> 0 SET @Amount = @TotalMiles * @Rate
		UPDATE Expense SET Total = @Amount, Amount = @Amount, TotalMiles = @TotalMiles WHERE ExpenseID = @ExpenseID	
	END
--	-- Otherwise apply the rate to the amount	
	ELSE
	BEGIN
		IF @Rate <> 0 SET @Amount = @Amount * @Rate
		UPDATE Expense SET Total = @Amount WHERE ExpenseID = @ExpenseID	
	END	
END
	
-- Deduction for this expense is based on percentage of business usage (from the MemberTax record)
IF @TaxType < 0 
BEGIN
	DECLARE @Use int
	SET @Rate = 0
	IF @ExpType = 1
		SELECT @Use = ISNULL(VehicleRate,0) FROM MemberTax WHERE MemberID = @MemberID AND Year = @Year
	IF @ExpType = 4
		SELECT @Use = ISNULL(SpaceRate,0) FROM MemberTax WHERE MemberID = @MemberID AND Year = @Year

	IF @Use <> 0 SET @Rate = CAST(@Use AS MONEY) / 100
	IF @Rate <> 0 SET @Amount = @Amount * @Rate
	UPDATE Expense SET Total = @Amount WHERE ExpenseID = @ExpenseID	
END		

GO