EXEC [dbo].pts_CheckProc 'pts_Downline_QualifyEnrollee'
GO

CREATE PROCEDURE [dbo].pts_Downline_QualifyEnrollee
   @MemberID int , 
   @Title int , 
   @EnrollDate datetime , 
   @Days int , 
   @Cnt int OUTPUT
AS

SET NOCOUNT ON
SET @Cnt = 0

IF @EnrollDate > 0
BEGIN
	SELECT @Cnt = COUNT(MemberID) FROM Member
	WHERE ReferralID = @MemberID 
	AND Title >= @Title
	AND dbo.wtfn_DateOnly(EnrollDate) <= DATEADD(d, @Days, @EnrollDate)
END
ELSE
BEGIN
	SELECT @Cnt = COUNT(MemberID) FROM Member
	WHERE ReferralID = @MemberID 
	AND Title >= @Title
END

GO
