EXEC [dbo].pts_CheckProc 'pts_Nexxus_Dashboard'
GO

--DECLARE @Result varchar(1000) EXEC pts_Nexxus_Dashboard 37702, @Result OUTPUT print @Result
--DECLARE @Result varchar(1000) EXEC pts_Payout_WalletTotal 4, 37703, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_Dashboard
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Member Dashboard
-- ***********************************************************************
DECLARE @CompanyID int, @Today datetime, @7Days datetime, @tmpResult varchar(100), @ID int, @Test int, @tmpMemberID int, @EnrollDate datetime
DECLARE @ReferralID int, @SponsorID int, @AuthUserID int, @EnrollDateStr varchar(20), @Title int, @Title2 int, @Founder varchar(20), @FastStart int, @FastStartStr varchar(10)
DECLARE @Personal int, @Group int, @Personal2 int, @Group2 int, @PaidDate datetime, @Days int, @Bonus money, @Qualify int, @ccs varchar(20)
DECLARE @Titlename varchar(40), @Titlename2 varchar(40), @Purpose varchar(100), @ProductName varchar(40)
DECLARE @QualifyName varchar(40), @QualifyName2 varchar(40), @Levels int, @Levels2 int, @CycleBonus money
DECLARE @NextTitle int, @NeedNext varchar(20), @RecruitDate datetime, @RecruitDate2 datetime
DECLARE @RecruitDateStr varchar(20), @RecruitDate2Str varchar(20), @PaidDateStr varchar(20)
DECLARE @Leader1a varchar(62), @Leader1b varchar(62)
DECLARE @Leader2a varchar(62), @Leader2b varchar(62)
DECLARE @Leader3a varchar(62), @Leader3b varchar(62)
DECLARE @Leader4a varchar(62), @Leader4b varchar(62)
DECLARE @Ticket1 int, @Ticket2 int, @Lead1 int, @Lead2 int, @Lead3 int, @Lead4 int
DECLARE @Cert1 int, @Cert2 int, @Cert3 int, @Cert4 int
DECLARE @Cert1m money, @Cert2m money, @Cert3m money, @Cert4m money
DECLARE @Available money, @Total money, @RetailDate datetime, @RetailStr varchar(10)
DECLARE @Reward1 int, @Reward2 int, @Reward3 int, @Reward4 int, @Reward5 int, @Reward6 money, @cnt int

SET @CompanyID = 21
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @Test = 0

SELECT @ReferralID = ReferralID, @SponsorID = SponsorID, @AuthUserID = AuthUserID, @EnrollDate = EnrollDate, @Title = Title, @Title2 = Title2, 
@Personal = BV, @Group = QV, @Personal2 = BV2, @Group2 = QV2
FROM Member WHERE MemberID = @MemberID

-- 1. Affiliate Info ----------------------------------------------------------------------------------
SELECT @Titlename = TitleName FROM Title WHERE CompanyID = @CompanyID AND TitleNo = @Title
SET @Founder = ''
SELECT @Founder = dbo.wtfn_DateOnlyStr(PaidDate) FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 3 AND Purpose = '999'
SET @EnrollDateStr = dbo.wtfn_DateOnlyStr(@EnrollDate)
SET @FastStartStr = ''
IF @EnrollDate < '10/1/17' SET @EnrollDate = '10/1/17'
--Exceptions - Rosalinda Burton
--IF @MemberID = 39032 SET SET @EnrollDate = '5/15/16'
SET @FastStart = 90 - DATEDIFF(day,@EnrollDate, @Today)
IF @FastStart < 0 SET @FastStart = 0
SET @FastStartStr = CAST( @FastStart AS varchar(10))

SET @Result = @EnrollDateStr + ';' + @Titlename + ';' + @Founder + ';' + @FastStartStr + '|' 
IF @Test > 0 PRINT @Result

-- 2. Certification Program ----------------------------------------------------------------------------------
SET @ProductName = ''
SET @PaidDate = -1
SET @PaidDateStr = ''
SET @Days = 0
SELECT TOP 1 @PaidDate = ISNULL(PaidDate,0), @Purpose = Purpose FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 3 AND Purpose IN ('101','102', '103', '106','107', '108')
ORDER BY PaidDate DESC
IF @PaidDate >= 0 
BEGIN
	SET @PaidDateStr = dbo.wtfn_DateOnlyStr(@PaidDate)
	SET @Days = 31 - DATEDIFF(day, @PaidDate, @Today) 
	IF @Days < 0 SET @Days = 0
	SELECT @ProductName = ProductName FROM Product WHERE CompanyID = @CompanyID AND CAST(Code AS VARCHAR(10)) = @Purpose
END
SET @ccs = ''
SELECT @ccs = dbo.wtfn_DateOnlyStr(CompleteDate) FROM MemberAssess WHERE MemberID = @MemberID AND AssessmentID = 20 AND Status = 1

SET @Result = @Result + @ProductName + ';' + @PaidDateStr + ';' + CAST(@Days AS VARCHAR(5)) + ';' + @ccs + '|' 
IF @Test > 0 PRINT @Result

-- 3. Sales Team ----------------------------------------------------------------------------------
SET @Result = @Result + CAST(@Personal AS VARCHAR(10)) + ';' + CAST(@Group AS VARCHAR(10)) + ';' + CAST(@Personal2 AS VARCHAR(10)) + ';' + CAST(@Group2 AS VARCHAR(10)) + '|' 
IF @Test > 0 PRINT @Result

-- 4. Finances ----------------------------------------------------------------------------------
SET @tmpResult = ''
SET @Bonus = 0
EXEC pts_Payout_WalletTotal 4, @MemberID, @tmpResult OUTPUT
IF @Test > 0 PRINT @tmpResult
SELECT @Bonus = ISNULL(SUM(Amount),0) FROM Commission WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 1
IF @Test > 0 PRINT @Bonus
SET @Result = @Result + @tmpResult + ';' + CAST(@Bonus AS VARCHAR(10)) + '|' 
IF @Test > 0 PRINT @Result

-- 5. Qualifications ----------------------------------------------------------------------------------
SET @QualifyName = 'Yes'
SET @QualifyName2 = 'Yes'
SET @Levels = 0
SET @CycleBonus = 0
SET @Levels2 = 0
EXEC pts_Nexxus_QualifiedMember  @MemberID, 1, 0, @Qualify OUTPUT
IF @Qualify = 1 SET @QualifyName = 'Not Active'
IF @Qualify = 2 SET @QualifyName = '< $10 PV'
IF @Qualify = 3 SET @QualifyName = '< $25 PV'
IF @Qualify = 4 SET @QualifyName = '< $50 PV'

	IF @Title2 = 3  -- 1 Star
	BEGIN
		SET @Levels = 1
		SET @CycleBonus = 0
		SET @Levels2 = 1
	END	
	IF @Title2 = 4  -- 2 Star
	BEGIN
		SET @Levels = 2
		SET @CycleBonus = 5
		SET @Levels2 = 1
	END	
	IF @Title2 = 5  -- 3 Star
	BEGIN
		SET @Levels = 3
		SET @CycleBonus = 5
		SET @Levels2 = 2
	END	
	IF @Title2 = 6  -- Diamond
	BEGIN
		SET @Levels = 4
		SET @CycleBonus = 5
		SET @Levels2 = 2
	END	
	IF @Title2 = 7  -- 2 Diamond
	BEGIN
		SET @Levels = 4
		SET @CycleBonus = 6
		SET @Levels2 = 3
	END	
	IF @Title2 = 8  -- 3 Diamond
	BEGIN
		SET @Levels = 5
		SET @CycleBonus = 6
		SET @Levels2 = 3
	END	
	IF @Title2 = 9  -- Platinum
	BEGIN
		SET @Levels = 5
		SET @CycleBonus = 7
		SET @Levels2 = 4
	END	
	IF @Title2 = 10  -- 2 Platinum
	BEGIN
		SET @Levels = 6
		SET @CycleBonus = 7
		SET @Levels2 = 5
	END	
	IF @Title2 = 11  -- 3 Platinum
	BEGIN
		SET @Levels = 6
		SET @CycleBonus = 8
		SET @Levels2 = 6
	END	
	IF @Title2 = 12  -- Ambassador
	BEGIN
		SET @Levels = 7
		SET @CycleBonus = 8
		SET @Levels2 = 7
	END	
	IF @Title2 = 13  -- 2 Ambassador
	BEGIN
		SET @Levels = 8
		SET @CycleBonus = 9
		SET @Levels2 = 8
	END	
	IF @Title2 = 14  -- 3 Ambassador
	BEGIN
		SET @Levels = 9
		SET @CycleBonus = 10
		SET @Levels2 = 9
	END	

EXEC pts_Nexxus_QualifiedMember  @MemberID, 2, 0, @Qualify OUTPUT
IF @Qualify = 1 SET @QualifyName2 = 'Not Active'
IF @Qualify = 2 SET @QualifyName2 = 'Not Bonus Qualified'
IF @Qualify = 3 SET @QualifyName2 = 'Missing Payout Method'
IF @Qualify = 4 SET @QualifyName2 = 'Missing Tax Id'
IF @Qualify = 5 SET @QualifyName2 = '< 70% Retail'
SELECT @Titlename = TitleName FROM Title WHERE CompanyID = @CompanyID AND TitleNo = @Title2
SET @Result = @Result + @Titlename + ';' + @QualifyName + ';' + @QualifyName2 + ';' + CAST(@Levels AS VARCHAR(10)) + ';' + CAST(@CycleBonus AS VARCHAR(10)) + ';' + CAST(@Levels2 AS VARCHAR(10)) + '|' 
IF @Test > 0 PRINT @Result

-- 6. Advancement ----------------------------------------------------------------------------------
SET @Titlename = ''
SET @RecruitDate = 0
SET @RecruitDate2 = 0
SET @RecruitDateStr = ''
SET @RecruitDate2Str = ''
SET @NeedNext = ''
IF @Title < 14
BEGIN
	SET @Title = @Title + 1
	SELECT @Titlename = TitleName FROM Title WHERE CompanyID = @CompanyID AND TitleNo = @Title
	EXEC pts_Commission_CalcAdvancement_21_Test @MemberID, @Title, 0, @Qualify OUTPUT, @NeedNext OUTPUT
END	
SELECT TOP 1 @RecruitDate = ISNULL(EnrollDate,0) FROM Member WHERE ReferralID = @MemberID ORDER BY EnrollDate DESC
SELECT TOP 1 @RecruitDate2 = ISNULL(EnrollDate,0) FROM Member WHERE ReferralID = @MemberID AND Title > 5 ORDER BY EnrollDate DESC
IF @RecruitDate > 0 SET @RecruitDateStr = dbo.wtfn_DateOnlyStr(@RecruitDate)
IF @RecruitDate2 > 0 SET @RecruitDate2Str = dbo.wtfn_DateOnlyStr(@RecruitDate2)
SET @Result = @Result + @Titlename + ';' + @NeedNext + ';' + @RecruitDateStr + ';' + @RecruitDate2Str + '|' 
IF @Test > 0 PRINT @Result

-- 7. Leadership ---------------------------------------------------------------------------------
SET @Leader1a = '' SET @Leader1b = ''
SET @Leader2a = '' SET @Leader2b = ''
SET @Leader3a = '' SET @Leader3b = ''
SET @Leader4a = '' SET @Leader4b = ''
IF @ReferralID > 0 SELECT @Leader1a = NameFirst + ' ' + NameLast, @Leader1b = Email + ' ' + Phone1, @Title = Title FROM Member WHERE MemberID = @ReferralID
SET @tmpMemberID = @ReferralID	

WHILE @Title <= 14 AND @tmpMemberID > 0
BEGIN
--print cast(@tmpMemberID as varchar(10)) + ' - ' + cast(@Title as varchar(10))
	IF @Title >= 6 AND @Leader2a = ''
	BEGIN
		SELECT @Leader2a = NameFirst + ' ' + NameLast, @Leader2b = Email + ' ' + Phone1 FROM Member WHERE MemberID = @tmpMemberID
	END 	
	IF @Title >= 9 AND @Leader3a = ''
	BEGIN
		SELECT @Leader3a = NameFirst + ' ' + NameLast, @Leader3b = Email + ' ' + Phone1 FROM Member WHERE MemberID = @tmpMemberID
	END 	
	IF @Title >= 12 AND @Leader4a = ''
	BEGIN
		SELECT @Leader4a = NameFirst + ' ' + NameLast, @Leader4b = Email + ' ' + Phone1 FROM Member WHERE MemberID = @tmpMemberID
		SET @ReferralID = 0
	END 
	SET @tmpMemberID = @ReferralID	
	SELECT @ReferralID = ReferralID, @Title = Title FROM Member WHERE MemberID = @tmpMemberID
END

SET @Result = @Result + @Leader1a + ';' + @Leader1b + ';' + @Leader2a + ';' + @Leader2b + ';' + @Leader3a + ';' + @Leader3b + ';' + @Leader4a + ';' + @Leader4b + '|'
IF @Test > 0 PRINT @Result

-- 8. Support ----------------------------------------------------------------------------------
SET @Ticket1 = 0
SET @Ticket2 = 0
SELECT @Ticket1 = COUNT(*) FROM Issue WHERE SubmitType = 4 AND SubmitID = @MemberID AND Status < 4
SELECT @Ticket2 = COUNT(*) FROM Issue WHERE SubmitType = 4 AND SubmitID = @MemberID
SET @Result = @Result + CAST(@Ticket1 AS VARCHAR(10)) + ';' + CAST(@Ticket2 AS VARCHAR(10)) + '|'
IF @Test > 0 PRINT @Result

-- 9. Marketing ----------------------------------------------------------------------------------
SET @Lead1 = 0
SET @Lead2 = 0
SET @Lead3 = 0
SET @Lead4 = 0
SET @7Days = DATEADD(DAY, -7, @Today)
SELECT @Lead1 = COUNT(*) FROM Prospect WHERE MemberID = @MemberID AND Status < 0 AND CreateDate > @7Days
SELECT @Lead2 = COUNT(*) FROM Prospect WHERE MemberID = @MemberID AND Status < 0
--SELECT @Lead3 = COUNT(*) FROM LeadCampaign WHERE CompanyID = @CompanyID AND PageType = 1 AND Status = 2
--SELECT @Lead4 = COUNT(*) FROM LeadCampaign WHERE CompanyID = @CompanyID AND PageType = 2 AND Status = 2
SET @Result = @Result + CAST(@Lead1 AS VARCHAR(10)) + ';' + CAST(@Lead2 AS VARCHAR(10)) + ';' + CAST(@Lead3 AS VARCHAR(10)) + ';' + CAST(@Lead4 AS VARCHAR(10)) + '|'
IF @Test > 0 PRINT @Result

-- 10. Product Certificates ----------------------------------------------------------------------------------
SET @Cert1 = 0
SET @Cert2 = 0
SET @Cert3 = 0
SET @Cert4 = 0
SET @Cert1m = 0.00
SET @Cert2m = 0.00
SET @Cert3m = 0.00
SET @Cert4m = 0.00
SELECT @Cert1 = COUNT(*) FROM Gift WHERE MemberID = @MemberID AND Member2ID = 0 AND Purpose != 'Shared'
SELECT @Cert2 = COUNT(*) FROM Gift WHERE MemberID = @MemberID AND Member2ID = 0 AND Purpose = 'Shared'
SELECT @Cert3 = COUNT(*) FROM Gift WHERE MemberID = @MemberID AND Member2ID != 0
SET @Cert4 = @Cert1 + @Cert2 + @Cert3
IF @Cert1 > 0 SELECT @Cert1m = ISNULL(SUM(Amount),0) FROM Gift WHERE MemberID = @MemberID AND Member2ID = 0 AND Purpose != 'Shared'
IF @Cert2 > 0 SELECT @Cert2m = ISNULL(SUM(Amount),0) FROM Gift WHERE MemberID = @MemberID AND Member2ID = 0 AND Purpose = 'Shared'
IF @Cert3 > 0 SELECT @Cert3m = ISNULL(SUM(Amount),0) FROM Gift WHERE MemberID = @MemberID AND Member2ID != 0
SET @Cert4m = @Cert1m + @Cert2m + @Cert3m

SET @RetailDate = DATEADD(day,-31,@Today)
SELECT @Total = ISNULL(SUM(Amount),0) FROM Gift WHERE MemberID = @MemberID AND GiftDate < @RetailDate
SELECT @Available = ISNULL(SUM(Amount),0) FROM Gift WHERE MemberID = @MemberID AND GiftDate < @RetailDate  AND Member2ID > 0
IF @Total > 0
	SET @RetailStr = CAST( CAST( (@Available / @Total) * 100 AS INT ) AS varchar(10))
ELSE 
	SET @RetailStr = '100'	

SET @Result = @Result + CAST(@Cert1 AS VARCHAR(10)) + ';' + CAST(@Cert2 AS VARCHAR(10)) + ';' + CAST(@Cert3 AS VARCHAR(10)) + ';' + CAST(@Cert4 AS VARCHAR(10)) + ';'
SET @Result = @Result + CAST(@Cert1m AS VARCHAR(15)) + ';' + CAST(@Cert2m AS VARCHAR(15)) + ';' + CAST(@Cert3m AS VARCHAR(15)) + ';' + CAST(@Cert4m AS VARCHAR(15)) + ';' + @RetailStr + '|'

-- 11. Nexxus Rewards ----------------------------------------------------------------------------------
SET @Reward1 = 0
SET @Reward2 = 0
SET @Reward3 = 0
SET @Reward4 = 0
SET @Reward5 = 0
SET @Reward6 = 0.00
SELECT @Reward1 = COUNT(*) FROM Consumer WHERE MemberID = @MemberID AND ReferID = 0
SELECT @Reward2 = COUNT(*) FROM Consumer WHERE MemberID = @MemberID
-- get affiliate merchant's shopper networks
SELECT @Reward2 = @Reward2 + COUNT(*) FROM Consumer AS co JOIN Merchant AS me ON co.MerchantID = me.MerchantID WHERE me.MemberID = @MemberID
SELECT @Reward3 = COUNT(*) FROM Merchant WHERE MemberID = @MemberID AND IsOrg != 0
SELECT @Reward4 = COUNT(*) FROM Merchant WHERE MemberID = @MemberID AND IsOrg = 0
SELECT @Reward5 = COUNT(*) FROM Merchant WHERE MemberID = @MemberID AND IsOrg = 0 AND Status = 3 AND Options NOT LIKE '%*%'
SELECT @Reward6 = ISNULL(SUM(Amount),0) FROM Commission WHERE OwnerType = 4 AND OwnerID = @MemberID AND CommType = 27

SET @Result = @Result + CAST(@Reward1 AS VARCHAR(10)) + ';' + CAST(@Reward2 AS VARCHAR(10)) + ';' + CAST(@Reward3 AS VARCHAR(10)) + ';' + CAST(@Reward4 AS VARCHAR(10)) + ';' + CAST(@Reward5 AS VARCHAR(10)) + ';' + CAST(@Reward6 AS VARCHAR(15))

IF @Test > 0 PRINT @Result

GO

