EXEC [dbo].pts_CheckProc 'pts_GCR_Qualified'
GO

--declare @Result varchar(1000) EXEC pts_GCR_Qualified 2, '9/10/14', @Result output print @Result

CREATE PROCEDURE [dbo].pts_GCR_Qualified
   @Status int ,
   @czDate datetime ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @Count int, @BV money, @QualifyDate datetime
SET @CompanyID = 17
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
	WHERE CompanyID = @CompanyID AND ( Qualify = 1 OR Qualify = 2 )
--	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND ( Qualify = 1 OR  Qualify = 2 )
	
	UPDATE Member SET Qualify = 0 
	WHERE CompanyID = @CompanyID AND Qualify = 3 AND QualifyDate > 0 AND QualifyDate < @czDate
--	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Qualify = 3 AND QualifyDate > 0 AND QualifyDate < @czDate

--	--------------------------------------------------------------------------------------------------------
--	set all active member's bonus qualified flag if they are active affiliates 
--	--------------------------------------------------------------------------------------------------------
	UPDATE Member SET Qualify = 2 
	WHERE CompanyID = @CompanyID AND Status = 1 AND Qualify = 0 -- AND Title > 1 AND Price > 0
	
--	--------------------------------------------------------------------------------------------------------
--	set all trial member's bonus qualified flag if they are less than 14 days old 
--	--------------------------------------------------------------------------------------------------------
	SET @QualifyDate = DATEADD( day, -14, GETDATE())
	UPDATE Member SET Qualify = 2 
	WHERE CompanyID = @CompanyID AND Status = 2 AND EnrollDate > @QualifyDate AND Qualify = 0 

--	--------------------------------------------------------------------------------------------------------
--	active billable members must have a $29.95+ approved payment within 1 month (10 day buffer) 
--	--------------------------------------------------------------------------------------------------------
	SET @QualifyDate = DATEADD( day, -40, GETDATE())
	UPDATE Member SET Qualify = 0 
	WHERE CompanyID = @CompanyID AND Status = 1 AND Billing = 3 AND Qualify = 2
	AND 0 = ( SELECT COUNT(*) FROM Payment 
	WHERE OwnerType = 4 AND OwnerID = Member.MemberID AND Status = 3 AND Amount >= 29.95 AND PaidDate > @QualifyDate)
	
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
	
--	-- ***** Check for a verified Payout Wallet with Wallet ID *****
	UPDATE me SET IsIncluded = 1
	FROM Member AS me
	LEFT OUTER JOIN Billing AS bi ON me.PayID = bi.BillingID
	WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Title > 0
	AND bi.commtype = 4 AND bi.CardType = 14 AND bi.CardName <> ''

--	-- ***** Check for declined payments *****
--	UPDATE me SET IsIncluded = 0
--	FROM Member AS me
--	WHERE me.CompanyID = @CompanyID AND me.IsIncluded != 0
--	AND ( SELECT COUNT(*) FROM Payment WHERE OwnerType = 4 AND OwnerID = me.MemberID AND Status = 4 ) > 0

--  Member must be active to receive payouts
	UPDATE me SET IsIncluded = 0
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID AND Status != 1
	
--	--------------------------------------------------------------------------------------------------------
--	active billable members must have a $29.95+ approved payment within 1 month (10 day buffer) 
--	--------------------------------------------------------------------------------------------------------
	SET @QualifyDate = DATEADD( day, -40, GETDATE())
	UPDATE Member SET IsIncluded = 0 
	WHERE CompanyID = @CompanyID AND Status = 1 AND Billing = 3 AND IsIncluded != 0
	AND 0 = ( SELECT COUNT(*) FROM Payment 
	WHERE OwnerType = 4 AND OwnerID = Member.MemberID AND Status = 3 AND Amount >= 29.95 AND PaidDate > @QualifyDate)

--	return number of qualified members
	SELECT @Count = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND IsIncluded != 0
END

SET @Result = CAST(@Count AS VARCHAR(10))

GO