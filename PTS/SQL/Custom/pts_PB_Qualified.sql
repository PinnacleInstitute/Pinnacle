EXEC [dbo].pts_CheckProc 'pts_PB_Qualified'
GO

--declare @Result varchar(1000) EXEC pts_PB_Qualified 1, '12/5/13', @Result output print @Result

CREATE PROCEDURE [dbo].pts_PB_Qualified
   @Status int ,
   @czDate datetime ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @Count int, @BV money
SET @CompanyID = 11
SET @BV = 0

-- *******************************************************************
-- Specify qualified member's that can receive bonuses
-- *******************************************************************
IF @Status = 1
BEGIN
--	--------------------------------------------------------------------------------------------------------
--	initialize all active member's bonus qualified flag to 0 if not locked (2)
--	initialize all active member's bonus qualified flag to 0 if locked (2) and QualifyDate is set and is past
--	--------------------------------------------------------------------------------------------------------
	UPDATE Member SET Qualify = 0 
	WHERE CompanyID = @CompanyID AND ( Qualify = 1 OR  Qualify = 2 )
--	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND ( Qualify = 1 OR  Qualify = 2 )
	
	UPDATE Member SET Qualify = 0 
	WHERE CompanyID = @CompanyID AND Qualify = 3 AND QualifyDate > 0 AND QualifyDate < @czDate
--	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Qualify = 3 AND QualifyDate > 0 AND QualifyDate < @czDate

--	--------------------------------------------------------------------------------------------------------
--	set all active member's bonus qualified flag if they are active affiliates with a title of Affiliate
--	--------------------------------------------------------------------------------------------------------
	UPDATE Member SET Qualify = 2 
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Qualify = 0 AND Title = 1
--	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Qualify = 0 AND Title >= 1

--	--------------------------------------------------------------------------------------------------------
--	check for required previous month sales volume for all active member's with a title > Affiliate
--	--------------------------------------------------------------------------------------------------------
	DECLARE @MemberID int, @Title int, @QualifyDate datetime, @Qualify int
	SET @QualifyDate = dbo.wtfn_DateOnly(GETDATE())
	SET @QualifyDate = DATEADD(M,-1,@QualifyDate)

	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID, Title
	FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Qualify = 0 AND Title > 1
	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Qualify = 0
		EXEC pts_PB_QualifiedSales @MemberID, @Title, @QualifyDate, @Qualify OUTPUT
		IF @Qualify = 1 UPDATE Member SET Qualify = 2 WHERE MemberID = @MemberID

		FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor
	
--	return number of qualified members
	SELECT @Count = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND Qualify > 1
END

-- *******************************************************************
-- Specify qualified member's that can receive a bonus check
-- *******************************************************************
IF @Status = 2
BEGIN
--	-- ***** START by marking all members not qualified *****
	UPDATE Member SET IsIncluded = 0 WHERE CompanyID = @CompanyID AND Title > 0
	
--	-- ***** Check for a verified Payout ACH or a Paper Check *****
	UPDATE me SET IsIncluded = 1
	FROM Member AS me
	LEFT OUTER JOIN Billing AS bi ON me.PayID = bi.BillingID
	WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Title > 0
	AND ( bi.commtype = 2 OR bi.commtype = 3 OR bi.commtype = 4 )

--	-- ***** Check for declined payments *****
	UPDATE me SET IsIncluded = 0
	FROM Member AS me
	Join SalesOrder AS so ON me.MemberID = so.MemberID
	WHERE me.CompanyID = 9 AND me.IsIncluded != 0
	AND ( SELECT COUNT(*) FROM Payment WHERE OwnerID = so.SalesOrderID AND Status = 4 ) > 0
	
--	-- ***** Check for missing billing Info *****
--	UPDATE me SET IsIncluded = 0
--	FROM Member AS me
--	WHERE me.CompanyID = @CompanyID AND me.IsIncluded != 0 AND me.BillingID = 0 AND me.Billing = 3
	
--	return number of qualified members
	SELECT @Count = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND IsIncluded != 0
END

SET @Result = CAST(@Count AS VARCHAR(10))

GO