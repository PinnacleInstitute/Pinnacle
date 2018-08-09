EXEC [dbo].pts_CheckProc 'pts_Nexxus_QualifiedMember'
GO

--declare @Result int EXEC pts_Nexxus_QualifiedMember 40611, 1, 0, @Result output print @Result
--declare @Result int EXEC pts_Nexxus_QualifiedMember 37702, 2, 0, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_QualifiedMember
   @MemberID int ,
   @Option int ,
   @Date datetime,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @newQualify int, @QualifyDate datetime, @Qualify int, @Qualify2 int, @Status int, @Title int, @Price money, @Role nvarchar(15) 
DECLARE @CommType int, @CardType int, @Cnt int, @BV2 money, @RetailDate datetime, @Total money, @Available money

IF @Date = 0 SET @Date = GETDATE()
SET @Result = 0 

-- *******************************************************************
-- Specify qualified member's that can receive bonuses
-- *******************************************************************
IF @Option = 1
BEGIN
	SELECT @Status = Status, @Qualify = Qualify, @QualifyDate = QualifyDate, @Title = Title, @BV2 = BV2 FROM Member WHERE MemberID = @MemberID  
	
--	Check if they are Not Qualify locked
	IF @Qualify < 3 OR (@QualifyDate > 0 AND @QualifyDate < @Date )
	BEGIN
		SET @newQualify = @Qualify
		SET @Result = 0 -- Default Qualified 

--		Check if they are an active or trial member
		IF @Result = 0 AND @Status != 1 SET @Result = 1 -- Not Active Member

--		Check if they have required sales volume for their title
		IF @Result = 0
		BEGIN
			IF @Title >= 3 AND @Title <= 5 AND @BV2 < 9.95 SET @Result = 2 -- < $10 Personal Sales Volume
			IF @Title >= 6 AND @Title <= 7 AND @BV2 < 24.95 SET @Result = 3 -- < $25 Personal Sales Volume
			IF @Title >= 8 AND @Title <= 14 AND @BV2 < 49.95 SET @Result = 4 -- < $50 Personal Sales Volume
		END
		
--		Update Member if Qualify changed
		IF @Result = 0 SET @newQualify = 2 ELSE SET @newQualify = 1
		IF @newQualify != @Qualify	UPDATE Member SET Qualify = @newQualify WHERE MemberID = @MemberID
	END
END

-- *******************************************************************
-- Specify qualified member's that can receive a bonus check
-- *******************************************************************
IF @Option = 2
BEGIN
	SELECT @Status = me.Status, @Qualify = me.IsIncluded, @Title = me.Title, @CommType = bi.CommType, @CardType = bi.CardType, @Qualify2 = Qualify, @Role = Role  
	FROM Member AS me LEFT OUTER JOIN Billing AS bi ON me.PayID = bi.BillingID
	WHERE MemberID = @MemberID  

	SET @newQualify = @Qualify
	SET @Result = 0 -- Default Qualified 

--	Check if they are an active member
	IF @Result = 0 AND @Status != 1 SET @Result = 1 -- Not Active Member

--	Check if they are bonus qualified
	IF @Result = 0 AND @Qualify2 < 2 AND @Role = '' SET @Result = 2 -- Not Bonus Qualified

--	Check for a verified Payout Wallet 
	IF @Result = 0 AND (@Title <= 0 OR @CommType != 4 OR @CardType NOT IN (14,16,17)) SET @Result = 3 -- No Payout Method

--	Check for U.S. Members with $600 earnings and NO Tax ID
	IF @Result = 0 
	BEGIN
		SELECT @Cnt = COUNT(*) FROM Address WHERE OwnerID = @MemberID and CountryID = 224
		IF @Cnt > 0
		BEGIN
			SELECT @Price = SUM(Amount) FROM Payout WHERE OwnerID = @MemberID and Amount > 0 and PayType = 91
			IF @Price >= 600
			BEGIN
				SELECT @Cnt = COUNT(*) FROM Govid WHERE MemberID = @MemberID and GType IN (1,2) AND GNumber <> ''
				IF @Cnt = 0 SET @Result = 4 -- No Tax ID		
			END
		END
	END

--	Check for 70% Retail Sales
	IF @Result = 0
	BEGIN
--		Get Total certificates older than 31 days
		SET @RetailDate = DATEADD(d, -31, @Date)
		SET @Total = 0
		SELECT @Total = ISNULL(SUM(Amount),0) FROM Gift WHERE MemberID = @MemberID AND GiftDate < @RetailDate
		IF @Total > 0
		BEGIN 
--			Get Total registered certificates older than 31 days
			SELECT @Available = ISNULL(SUM(Amount),0) FROM Gift WHERE MemberID = @MemberID AND GiftDate < @RetailDate  AND Member2ID > 0
--			Test if registered certificates is 70%+ of the total
			IF ( @Available / @Total ) < .7 SET @Result = 5 -- < 70% Retail	
		END
	END

--	Update Member if Qualify changed
	IF @Result = 0 SET @newQualify = 1 ELSE SET @newQualify = 0
	IF @newQualify != @Qualify UPDATE Member SET IsIncluded = @newQualify WHERE MemberID = @MemberID

END

GO
