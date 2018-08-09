EXEC [dbo].pts_CheckProc 'pts_Legacy_QualifiedMember'
GO

--declare @Result int EXEC pts_Legacy_QualifiedMember 7164, 1, 0, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Legacy_QualifiedMember
   @MemberID int ,
   @Option int ,
   @Date datetime,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @newQualify int, @QDate datetime, @QualifyDate datetime, @EnrollDate datetime, @Qualify int, @Status int, @Level int, @Title int, @Price money, @Billing int, @Paid money, @Options2 VARCHAR(100)
DECLARE @CommType int, @Cnt int
SET @Result = 0 -- Default Qualified 
IF @Date = 0 SET @Date = GETDATE()

-- *******************************************************************
-- Specify qualified member's that can receive bonuses
-- *******************************************************************
IF @Option = 1
BEGIN
	SELECT @EnrollDate = EnrollDate, @Status = Status, @Level = Level, @Qualify = Qualify, @QualifyDate = QualifyDate, @Title = Title, @Price = Price, @Billing = Billing, @Options2 = Options2 
	FROM Member WHERE MemberID = @MemberID  

--	Check if they are Not Qualify locked
	IF @Qualify < 3 OR (@QualifyDate > 0 AND @QualifyDate < @Date )
	BEGIN
		-- All Members are qualified in their first 14 days
		IF @EnrollDate > DATEADD( day, -14, GETDATE())
		BEGIN
			UPDATE Member SET Qualify = 2 WHERE MemberID = @MemberID
		END
		ELSE
		BEGIN
			SET @newQualify = @Qualify

--			Check if they are a Test Drive Afiliate
			IF @Result = 0 AND @Level = 2 SET @Result = 6 -- Only Test Drive Affiliate

--			Check if they are an active or suspended member
			IF @Result = 0 AND @Status NOT IN (1,4) SET @Result = 1 -- Not Active Member

--			Check if they have an autoship
			IF @Result = 0 AND @Title > 0  AND @Billing IN (3,5) AND @Price = 0 SET @Result = 2 -- No Autoship

--			Check for suspended billable member with < $19.95+ approved payment within 10 days 
			IF @Result = 0 AND @Status = 4 AND @Billing IN (3,5) 
			BEGIN
				SET @QDate = DATEADD( day, -10, GETDATE())
				SELECT @Paid = ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
				WHERE so.MemberID = @MemberID AND pa.Status = 3 AND pa.PayDate > @QDate
				IF @Paid < 19.95 SET @Result = 3 -- Suspended with No Payment within 10 days
			END

--			Check for active billable member with < $19.95+ approved payment within 40 days (not quarterly autoship)
			IF @Result = 0 AND @Status = 1 AND @Billing IN (3,5) AND CHARINDEX('114', @Options2) = 0 AND CHARINDEX('116', @Options2) = 0 
				AND CHARINDEX('118', @Options2) = 0 AND CHARINDEX('120', @Options2) = 0 AND CHARINDEX('121', @Options2) = 0 
			BEGIN
				SET @QDate = DATEADD( day, -40, GETDATE())
				SELECT @Paid = ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
				WHERE so.MemberID = @MemberID AND pa.Status = 3 AND pa.PayDate > @QDate
				IF @Paid < 19.95 SET @Result = 4 -- Active monthly with No Payment within 40 days
			END

--			Check active billable member with < $19.95+ approved payment within 100 days (quarterly autoship)
			IF @Result = 0 AND @Status = 1 AND @Billing IN (3,5) AND ( CHARINDEX('114', @Options2) != 0 OR CHARINDEX('116', @Options2) != 0 
				OR CHARINDEX('118', @Options2) != 0 OR CHARINDEX('120', @Options2) != 0 OR CHARINDEX('121', @Options2) != 0 )
			BEGIN
				SET @QDate = DATEADD( day, -100, GETDATE())
				SELECT @Paid = ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
				WHERE so.MemberID = @MemberID AND pa.Status = 3 AND pa.PayDate > @QDate
				IF @Paid < 19.95 SET @Result = 5 -- Active quarterly with No Payment within 100 days
			END

--			Update Member if Qualify changed
			IF @Result = 0 SET @newQualify = 2 ELSE SET @newQualify = 1
			IF @newQualify != @Qualify	UPDATE Member SET Qualify = @newQualify WHERE MemberID = @MemberID
			
--			If NOT Bonus Qualified, Flush their Binay Volume
--			IF @Result > 0
--			BEGIN
--				First, save their binary volume in QV2 if not already saved
--				UPDATE Member SET QV3 = QV4 WHERE Sponsor3ID = @MemberID AND QV3 = 0
--				UPDATE Member SET QV4 = 0 WHERE Sponsor3ID = @MemberID
--			END			
		END
	END
END

-- *******************************************************************
-- Specify qualified member's that can receive a bonus check
-- *******************************************************************
IF @Option = 2
BEGIN
	SELECT @EnrollDate = EnrollDate, @Status = me.Status, @Level = me.Level, @Qualify = me.IsIncluded, @Title = me.Title, @Price = me.Price, @Billing = me.Billing, @Options2 = me.Options2, @CommType = bi.CommType 
	FROM Member AS me LEFT OUTER JOIN Billing AS bi ON me.PayID = bi.BillingID
	WHERE MemberID = @MemberID  

	SET @newQualify = @Qualify

--	Check if they are a Test Drive Afiliate
	IF @Result = 0 AND @Level = 2 SET @Result = 8 -- Only Test Drive Affiliate

--	Check if they are an active or suspended member
	IF @Result = 0 AND @Status NOT IN (1,4) SET @Result = 1 -- Not Active Member

--	Check for a Payout Method 
	IF @Result = 0 AND @Status = 1 AND @Title > 0 AND @CommType NOT IN (2,3,4) SET @Result = 2 -- No Payout Method

--	Check for suspended billable member with < $19.95+ approved payment within 10 days 
	IF @Result = 0 AND @Status = 4 AND @Billing IN (3,5) 
	BEGIN
		SET @QDate = DATEADD( day, -10, GETDATE())
		SELECT @Paid = ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = @MemberID AND pa.Status = 3 AND pa.PayDate > @QDate
		IF @Paid < 19.95 SET @Result = 3 -- Suspended with No Payment within 10 days
	END

--	Check for active billable member with < $19.95+ approved payment within 40 days (not quarterly autoship)
	IF @Result = 0 AND @Status = 1 AND @Billing IN (3,5) AND CHARINDEX('114', @Options2) = 0 AND CHARINDEX('116', @Options2) = 0 
		AND CHARINDEX('118', @Options2) = 0 AND CHARINDEX('120', @Options2) = 0 AND CHARINDEX('121', @Options2) = 0 
	BEGIN
		SET @QDate = DATEADD( day, -40, GETDATE())
		SELECT @Paid = ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = @MemberID AND pa.Status = 3 AND pa.PayDate > @QDate
		IF @Paid < 19.95 SET @Result = 4 -- Active monthly with No Payment within 40 days
	END

--	Check active billable member with < $19.95+ approved payment within 100 days (quarterly autoship)
	IF @Result = 0 AND @Status = 1 AND @Billing IN (3,5) AND ( CHARINDEX('114', @Options2) != 0 OR CHARINDEX('116', @Options2) != 0 
		OR CHARINDEX('118', @Options2) != 0 OR CHARINDEX('120', @Options2) != 0 OR CHARINDEX('121', @Options2) != 0 )
	BEGIN
		SET @QDate = DATEADD( day, -100, GETDATE())
		SELECT @Paid = ISNULL(SUM(pa.Amount),0) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = @MemberID AND pa.Status = 3 AND pa.PayDate > @QDate
		IF @Paid < 19.95 SET @Result = 5 -- Active quarterly with No Payment within 100 days
	END

--	Check for declined payments 
	IF @Result = 0 
	BEGIN
		SELECT @Cnt = COUNT(*) FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE so.MemberID = @MemberID AND pa.Status = 4
		IF @Cnt > 0 SET @Result = 6 -- Declined Payments		
	END

--	Check for U.S. Members with $600 earnings and NO Tax ID
	IF @Result = 0 
	BEGIN
		SELECT @Cnt = COUNT(*) FROM Address WHERE OwnerID = @MemberID and CountryID = 224
		IF @Cnt > 0
		BEGIN
			SELECT @Price = SUM(Amount) FROM Payout WHERE OwnerID = @MemberID and Amount > 0
			IF @Price >= 600
			BEGIN
				SELECT @Cnt = COUNT(*) FROM Govid WHERE MemberID = @MemberID and GType IN (1,2) AND GNumber <> ''
				IF @Cnt = 0 SET @Result = 7 -- No Tax ID		
			END
		END
	END

--	Update Member if Qualify changed
	IF @Result = 0 SET @newQualify = 1 ELSE SET @newQualify = 0
	IF @newQualify != @Qualify UPDATE Member SET IsIncluded = @newQualify WHERE MemberID = @MemberID
END

GO