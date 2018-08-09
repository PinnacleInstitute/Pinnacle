EXEC [dbo].pts_CheckProc 'pts_CIS_Qualified'
GO

--declare @Result varchar(1000) EXEC pts_CIS_Qualified 2, '6/3/12', @Result output print @Result

CREATE PROCEDURE [dbo].pts_CIS_Qualified
   @Status int ,
   @czDate datetime ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @Count int, @Today datetime
SET @CompanyID = 15
SET @Today = dbo.wtfn_DateOnly(GETDATE())

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
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Qualify = 0
	AND Title > 0 OR (Title = 0 AND EnrollDate > DATEADD(d, -7, @Today) ) 

--	return number of qualified members
	SELECT @Count = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND Qualify > 1
END

-- *******************************************************************
-- Specify qualified member's that can receive a bonus check
-- *******************************************************************
IF @Status = 2
BEGIN
--	-- ***** START by marking all members not qualified *****
	UPDATE Member SET IsIncluded = 0 WHERE CompanyID = @CompanyID
	
--	-- ***** Check for a verified Payout ACH or a Paper Check *****
	UPDATE me SET IsIncluded = 1
	FROM Member AS me
	LEFT OUTER JOIN Billing AS bi ON me.PayID = bi.BillingID
	WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Title > 0
	AND ( bi.commtype = 2 OR bi.commtype = 3 OR bi.commtype = 4 )

--	-- ***** Check for declined payments *****
	UPDATE me SET IsIncluded = 0
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID AND me.IsIncluded != 0
	AND ( SELECT COUNT(*) FROM Payment WHERE OwnerType = 4 AND OwnerID = me.MemberID AND Status = 4 ) > 0
	
--	-- ***** Don't pay level 0 *****
	UPDATE me SET IsIncluded = 0
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID AND me.IsIncluded != 0 AND me.Level = 0
	
--	return number of qualified members
	SELECT @Count = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND IsIncluded != 0
END

SET @Result = CAST(@Count AS VARCHAR(10))

GO