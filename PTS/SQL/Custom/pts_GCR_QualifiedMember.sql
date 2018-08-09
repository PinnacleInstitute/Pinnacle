EXEC [dbo].pts_CheckProc 'pts_GCR_QualifiedMember'
GO

--declare @Result int EXEC pts_GCR_QualifiedMember 23326, 1, 0, @Result output print @Result

CREATE PROCEDURE [dbo].pts_GCR_QualifiedMember
   @MemberID int ,
   @Option int ,
   @Date datetime,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @newQualify int, @QualifyDate datetime, @EnrollDate datetime, @Qualify int, @Status int, @Title int, @Price money, @Billing int, @Paid money, @Options2 VARCHAR(100)
DECLARE @CommType int, @CardType int, @CardName VARCHAR(100), @Cnt int

IF @Date = 0 SET @Date = GETDATE()

-- *******************************************************************
-- Specify qualified member's that can receive bonuses
-- *******************************************************************
IF @Option = 1
BEGIN
	SELECT @EnrollDate = EnrollDate, @Status = Status, @Qualify = Qualify, @QualifyDate = QualifyDate, @Title = Title, @Price = Price, @Billing = Billing, @Options2 = Options2 
	FROM Member WHERE MemberID = @MemberID  
	
--	Check if they are Not Qualify locked
	IF @Qualify < 3 OR (@QualifyDate > 0 AND @QualifyDate < @Date )
	BEGIN
--		Special automatically qualify these 5 positions for Linda Helin		
		IF @MemberID IN (12551,12552,14100,19463,19464,12559)
		BEGIN
			UPDATE Member SET Qualify = 2 WHERE MemberID = @MemberID
		END
		ELSE
		BEGIN
			SET @newQualify = @Qualify
			SET @Result = 0 -- Default Qualified 

--			Check if they are an active or trial member
			IF @Result = 0 AND @Status != 1 AND @Status != 2 SET @Result = 1 -- Not Active/Trial Member

--			Check if they are a trial member older than 14 days
			IF @Result = 0 AND @Status = 2 
			BEGIN
				SET @QualifyDate = DATEADD( day, -14, GETDATE())
				IF @EnrollDate > @QualifyDate SET @Result = 2 -- Trial Member over 14 days
			END

--			Check if they are an active member with no $29.95+ approved payment within 1 month (10 day buffer) 
			IF @Result = 0 AND @Status = 1 AND @Billing = 3 AND @Title > 1 
			BEGIN
				SET @QualifyDate = DATEADD( day, -38, GETDATE())
				SELECT @Cnt = COUNT(*) FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status IN (2,3) AND PaidDate > @QualifyDate
				IF @Cnt = 0 SET @Result = 3 -- Active Member over 38 days
			END
			
--			Update Member if Qualify changed
			IF @Result = 0 SET @newQualify = 2 ELSE SET @newQualify = 1
			IF @newQualify != @Qualify	UPDATE Member SET Qualify = @newQualify WHERE MemberID = @MemberID
		END
	END
END

-- *******************************************************************
-- Specify qualified member's that can receive a bonus check
-- *******************************************************************
IF @Option = 2
BEGIN
	SELECT @Status = me.Status, @Qualify = me.IsIncluded, @Title = me.Title, @Price = me.Price, @Billing = me.Billing, @Options2 = me.Options2, 
	@CommType = bi.CommType, @CardType = bi.CardType, @CardName = bi.CardName 
	FROM Member AS me LEFT OUTER JOIN Billing AS bi ON me.PayID = bi.BillingID
	WHERE MemberID = @MemberID  

	SET @newQualify = @Qualify
	SET @Result = 0 -- Default Qualified 

--	Check if they are an active member
	IF @Result = 0 AND @Status != 1 SET @Result = 1 -- Not Active Member

--	Check for a verified Payout Wallet 
	IF @Result = 0 AND (@Title <= 0 OR @CommType != 4 OR @CardType NOT IN (13,14) OR @CardName = '') SET @Result = 2 -- No Payout Method

--	Special automatically qualify these 5 positions for Linda Helin		
	IF @MemberID IN (12551,12552,14100,19463,19464,12559) SET @Result = 0 

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
				IF @Cnt = 0 SET @Result = 3 -- No Tax ID		
			END
		END
	END

--	Update Member if Qualify changed
	IF @Result = 0 SET @newQualify = 1 ELSE SET @newQualify = 0
	IF @newQualify != @Qualify UPDATE Member SET IsIncluded = @newQualify WHERE MemberID = @MemberID
END

GO