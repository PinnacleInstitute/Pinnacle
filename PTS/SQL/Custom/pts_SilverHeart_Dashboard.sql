EXEC [dbo].pts_CheckProc 'pts_SilverHeart_Dashboard'
GO

--DECLARE @Result varchar(1000) EXEC pts_SilverHeart_Dashboard 12551, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_SilverHeart_Dashboard
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
DECLARE	@Now datetime, @StartDate datetime, @EndDate datetime, @Total int, @cnt int, @Title int, @Qualify int, @ReferralID int, @MentorID int
DECLARE @ID int, @ID2 int, @GroupID int, @tmpDate datetime, @tmpAmt money

DECLARE @Q1 int, @Q2 int
DECLARE @A1 varchar(100)
DECLARE @L11 varchar(61), @L12 varchar(80), @L13 varchar(30)
DECLARE @L21 varchar(61), @L22 varchar(80), @L23 varchar(30)
DECLARE @L31 varchar(61), @L32 varchar(80), @L33 varchar(30)
DECLARE @L41 varchar(61), @L42 varchar(80), @L43 varchar(30)
DECLARE @L51 varchar(61), @L52 varchar(80), @L53 varchar(30)
DECLARE @P1 money, @P3 money, @P99 money, @P1T varchar(15), @P3T varchar(15), @P99T varchar(15)
DECLARE @R1 varchar(20), @R2 varchar(20)
DECLARE @B1 varchar(20), @B2 varchar(20) 

SET @Q1=0
SET @Q2=0 
SET @A1=''
SET @L11=''
SET @L12=''
SET @L13=''
SET @L21=''
SET @L22=''
SET @L23=''
SET @L31=''
SET @L32=''
SET @L33=''
SET @L41=''
SET @L42=''
SET @L43=''
SET @L51=''
SET @L52=''
SET @L53=''
SET @P1=0.0
SET @P3=0.0 
SET @P99=0.0
SET @P1T=''
SET @P3T='' 
SET @P99T=''
SET @R1=''
SET @R2=''
SET @B1=''
SET @B2=''

SELECT @Title = Title, @ReferralID = ReferralID, @MentorID = MentorID FROM Member WHERE MemberID = @MemberID

-- Qualifications ---------------------------------------------------------------------------------
EXEC pts_SilverHeart_QualifiedMember  @MemberID, 1, 0, @Q1 OUTPUT
EXEC pts_SilverHeart_QualifiedMember  @MemberID, 2, 0, @Q2 OUTPUT

-- Advancement ---------------------------------------------------------------------------------
IF @Title < 10
BEGIN
	SET @Title = @Title + 1
	EXEC pts_Commission_CalcAdvancement_20_Test @MemberID, @Title, 0, @Qualify OUTPUT, @A1 OUTPUT
END

-- Get last recruit date
SET @tmpDate = 0
SELECT TOP 1 @tmpDate = EnrollDate FROM Member WHERE ReferralID = @MemberID ORDER BY EnrollDate DESC
IF @tmpDate > 0 SET @R1 = dbo.wtfn_DateOnlyStr(@tmpDate) 

-- Get last recruit date of Missionary
SET @tmpDate = 0
SELECT TOP 1 @tmpDate = EnrollDate FROM Member WHERE ReferralID = @MemberID AND Title >= 2 ORDER BY EnrollDate DESC
IF @tmpDate > 0 SET @R2 = dbo.wtfn_DateOnlyStr(@tmpDate) 

-- Get last order payment date
SET @tmpDate = 0
SELECT TOP 1 @tmpDate = pa.PaidDate, @tmpAmt = pa.Amount FROM Payment AS pa 
JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
WHERE so.MemberID = @MemberID AND pa.Status = 3
ORDER BY PaidDate DESC
IF @tmpDate > 0
BEGIN
	SET @B1 = '$'+ CONVERT(varchar(15),@tmpAmt, 1)
	SET @B2 = dbo.wtfn_DateOnlyStr(@tmpDate) 
END

-- Leadership ---------------------------------------------------------------------------------
IF @ReferralID > 0 SELECT @L11 = NameFirst + ' ' + NameLast,  @L12 = Email, @L13 = Phone1 FROM Member WHERE MemberID = @ReferralID
IF @MentorID   > 0 AND @MentorID <> @ReferralID SELECT @L21 = NameFirst + ' ' + NameLast,  @L22 = Email, @L23 = Phone1 FROM Member WHERE MemberID = @MentorID

SELECT @ID = ParentID FROM Downline WHERE Line = 2 AND ChildID = @MemberID
IF @ID > 0 SELECT @L31 = NameFirst + ' ' + NameLast,  @L32 = Email, @L33 = Phone1 FROM Member WHERE MemberID = @ID
SET @ID2 = @ID

SELECT @ID = ParentID FROM Downline WHERE Line = 3 AND ChildID = @MemberID
IF @ID > 0 AND @ID <> @ID2 SELECT @L41 = NameFirst + ' ' + NameLast,  @L42 = Email, @L43 = Phone1 FROM Member WHERE MemberID = @ID
SET @ID2 = @ID

SELECT @ID = ParentID FROM Downline WHERE Line = 4 AND ChildID = @MemberID
IF @ID > 0 AND @ID <> @ID2 SELECT @L51 = NameFirst + ' ' + NameLast,  @L52 = Email, @L53 = Phone1 FROM Member WHERE MemberID = @ID

-- Finances ---------------------------------------------------------------------------------
SET @Now = dbo.wtfn_DateOnly(GETDATE())

--Get last Wallet Bonus
select TOP 1 @P1 = Amount from Payout where OwnerType = 4 AND OwnerID = @MemberID AND Amount > 0 AND Show = 0 AND PayType = 91 ORDER BY PaidDate DESC
SET @P1T = '$'+ CONVERT(varchar(15),@P1, 1)

SET @StartDate = DATEADD(d, -90, @Now)
select @P3 = ISNULL(SUM(Amount),0) from Payout where OwnerType = 4 AND OwnerID = @MemberID AND Amount > 0 AND Show = 0 AND PayDate > @StartDate
SET @P3T = '$'+ CONVERT(varchar(15),@P3, 1)

select @P99 = ISNULL(SUM(Amount),0) from Payout where OwnerType = 4 AND OwnerID = @MemberID AND Amount > 0 AND Show = 0
SET @P99T = '$'+ CONVERT(varchar(15),@P99, 1)

SET @Result = '<PTSDASH ' + 
'q1="'  + CAST(@Q1 AS varchar(15)) + '" ' +
'q2="'  + CAST(@Q2 AS varchar(15))  + '" ' +
'a1="'  + CAST(@A1 AS varchar(15)) + '" ' +
'l11="'  + @L11 + '" ' +
'l12="'  + @L12 + '" ' +
'l13="'  + @L13 + '" ' +
'l21="'  + @L21 + '" ' +
'l22="'  + @L22 + '" ' +
'l23="'  + @L23 + '" ' +
'l31="'  + @L31 + '" ' +
'l32="'  + @L32 + '" ' +
'l33="'  + @L33 + '" ' +
'l41="'  + @L41 + '" ' +
'l42="'  + @L42 + '" ' +
'l43="'  + @L43 + '" ' +
'l51="'  + @L51 + '" ' +
'l52="'  + @L52 + '" ' +
'l53="'  + @L53 + '" ' +
'p1="'  + @P1T + '" ' +
'p3="'  + @P3T + '" ' +
'p99="' + @P99T + '" ' +
'r1="'  + @R1 + '" ' +
'r2="'  + @R2 + '" ' +
'b1="'  + @B1 + '" ' +
'b2="'  + @B2 + '" ' +
'/>'
GO

