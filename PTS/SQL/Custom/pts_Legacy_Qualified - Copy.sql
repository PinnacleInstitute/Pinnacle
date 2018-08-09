EXEC [dbo].pts_CheckProc 'pts_Legacy_Qualified'
GO
--589
--542
--declare @Result varchar(1000) EXEC pts_Legacy_Qualified 2, '12/31/14', @Result output print @Result

CREATE PROCEDURE [dbo].pts_Legacy_Qualified
   @Status int ,
   @czDate datetime ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @Count int, @BV money, @QualifyDate datetime
SET @CompanyID = 14
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
--	set all active member's bonus qualified flag if they are active affiliates with a title and an autoship
--	--------------------------------------------------------------------------------------------------------
	UPDATE Member SET Qualify = 2 
	WHERE CompanyID = @CompanyID AND (Status = 1 OR Status = 4) AND Qualify = 0 AND Title > 0 AND Price > 0

--	--------------------------------------------------------------------------------------------------------
--	suspended billable members must have a $19.95+ approved payment within 10 days 
--	--------------------------------------------------------------------------------------------------------
	SET @QualifyDate = DATEADD( day, -10, GETDATE())
	UPDATE me SET Qualify = 0 FROM Member AS me
	WHERE CompanyID = @CompanyID AND Status = 4 AND Billing = 3 AND Qualify != 0
	AND 19.95 > ( 
		SELECT ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = me.MemberID AND pa.Status = 3 AND pa.PaidDate > @QualifyDate
	)
--	--------------------------------------------------------------------------------------------------------
--	active billable members on monthly auto-ship must have a $19.95+ approved payment within 40 days 
--  product codes 114, 116, 118, 120, 121 are quarterly autoships
--	--------------------------------------------------------------------------------------------------------
	SET @QualifyDate = DATEADD( day, -40, GETDATE())
	UPDATE me SET Qualify = 0 FROM Member AS me
	WHERE CompanyID = @CompanyID AND Status = 1 AND Billing = 3 AND Qualify != 0
	AND CHARINDEX('114', Options2) = 0 
	AND CHARINDEX('116', Options2) = 0 
	AND CHARINDEX('118', Options2) = 0 
	AND CHARINDEX('120', Options2) = 0 
	AND CHARINDEX('121', Options2) = 0 
	AND 19.95 > ( 	
		SELECT ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = me.MemberID AND pa.Status = 3 AND pa.PaidDate > @QualifyDate
	)	
--	--------------------------------------------------------------------------------------------------------
--	active billable members on quarterly auto-ship must have a $19.95+ approved payment within 100 days 
--  product codes 114, 116, 118, 120, 121 are quarterly autoships
--	--------------------------------------------------------------------------------------------------------
	SET @QualifyDate = DATEADD( day, -100, GETDATE())
	UPDATE me SET Qualify = 0 FROM Member AS me
	WHERE CompanyID = @CompanyID AND Status = 1 AND Billing = 3 AND Qualify != 0
	AND ( CHARINDEX('114', Options2) != 0 OR CHARINDEX('116', Options2) != 0 OR CHARINDEX('118', Options2) != 0 OR CHARINDEX('120', Options2) != 0 OR CHARINDEX('121', Options2) != 0 )
	AND 19.95 > ( 	
		SELECT ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = me.MemberID AND pa.Status = 3 AND pa.PaidDate > @QualifyDate
	)	

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

--	--------------------------------------------------------------------------------------------------------
--	suspended billable members must have a $19.95+ approved payment within 10 days 
--	--------------------------------------------------------------------------------------------------------
	SET @QualifyDate = DATEADD( day, -10, GETDATE())
	UPDATE me SET IsIncluded = 0 FROM Member AS me
	WHERE me.CompanyID = @CompanyID AND me.Status = 4 AND me.Billing = 3 AND me.IsIncluded != 0
	AND 19.95 > ( 
		SELECT ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = me.MemberID AND pa.Status = 3 AND pa.PaidDate > @QualifyDate
	)	

--	--------------------------------------------------------------------------------------------------------
--	active billable members on monthly auto-ship must have a $19.95+ approved payment within 40 days 
--  product codes 114, 116, 118, 120, 121 are quarterly autoships
--	--------------------------------------------------------------------------------------------------------
	SET @QualifyDate = DATEADD( day, -40, GETDATE())
	UPDATE me SET IsIncluded = 0 FROM Member AS me
	WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing = 3 AND me.IsIncluded != 0
	AND CHARINDEX('114', Options2) = 0 
	AND CHARINDEX('116', Options2) = 0 
	AND CHARINDEX('118', Options2) = 0 
	AND CHARINDEX('120', Options2) = 0 
	AND CHARINDEX('121', Options2) = 0 
	AND 19.95 > ( 
		SELECT ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = me.MemberID AND pa.Status = 3 AND pa.PaidDate > @QualifyDate
	)	
--	--------------------------------------------------------------------------------------------------------
--	active billable members on quarterly auto-ship must have a $19.95+ approved payment within 100 days 
--  product codes 114, 116, 118, 120, 121 are quarterly autoships
--	--------------------------------------------------------------------------------------------------------
	SET @QualifyDate = DATEADD( day, -100, GETDATE())
	UPDATE me SET IsIncluded = 0 FROM Member AS me
	WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing = 3 AND me.IsIncluded != 0
	AND ( CHARINDEX('114', Options2) != 0 OR CHARINDEX('116', Options2) != 0 OR CHARINDEX('118', Options2) != 0 OR CHARINDEX('120', Options2) != 0 OR CHARINDEX('121', Options2) != 0 )
	AND 19.95 > ( 
		SELECT ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = me.MemberID AND pa.Status = 3 AND pa.PaidDate > @QualifyDate
	)	

--	-- ***** Check for declined payments *****
	UPDATE me SET IsIncluded = 0
	FROM Member AS me
	Join SalesOrder AS so ON me.MemberID = so.MemberID
	WHERE me.CompanyID = @CompanyID AND me.IsIncluded != 0
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