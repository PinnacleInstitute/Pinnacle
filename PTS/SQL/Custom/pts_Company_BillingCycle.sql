EXEC [dbo].pts_CheckProc 'pts_Company_BillingCycle'
GO

CREATE PROCEDURE [dbo].pts_Company_BillingCycle
   @CompanyID int,
   @BillDate datetime,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @cnt int

SET @Count = 0

-- If a Company is specified, process that company only
If @CompanyID > 0 
BEGIN
	SET @cnt = 0
	EXEC pts_Company_BillingPayments @CompanyID, @BillDate, @cnt OUTPUT
	SET @Count = @cnt
END

-- If a Company is not specified, process all active companies
If @CompanyID = 0 
BEGIN
	DECLARE @ID int
	
	DECLARE Company_cursor CURSOR LOCAL STATIC FOR 
	SELECT CompanyID FROM Company WHERE Status = 2
	
	OPEN Company_cursor
	FETCH NEXT FROM Company_cursor INTO @ID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @cnt = 0
		EXEC pts_Company_BillingPayments @ID, @BillDate, @cnt OUTPUT
		SET @Count = @Count + @cnt
		FETCH NEXT FROM Company_cursor INTO @ID
	END
	
	CLOSE Company_cursor
	DEALLOCATE Company_cursor
END

GO