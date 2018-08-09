EXEC [dbo].pts_CheckProc 'pts_Assessment_ListTB'
GO

--EXEC pts_Assessment_ListTB 84, '1/1/05', 15, 0 

CREATE PROCEDURE [dbo].pts_Assessment_ListTB ( 
   @MemberID int, 
   @VisitDate datetime,
   @Status int,
   @IsTrial bit
  )
AS
SET NOCOUNT ON

DECLARE @CompanyID int
SELECT @CompanyID=CompanyID FROM Member Where MemberID = @MemberID

-- TAKEN PUBLIC ASSESSMENTS
IF @Status = 15
BEGIN
	SELECT asm.AssessmentID, asm.AssessmentName, asm.Description, asm.AssessDate, asm.CompanyID, asm.Takes, asm.Delay
	FROM   MemberAssess AS ma
	JOIN Assessment AS asm ON (asm.AssessmentID = ma.AssessmentID)
	WHERE  asm.CompanyID = 0 AND ma.MemberID = @MemberID
	AND ( @IsTrial = 0 OR asm.IsTrial = @IsTrial )
END

-- NEW PUBLIC ASSESSMENTS FOR DATES
IF @Status = 13 OR @Status = 14
BEGIN
	SELECT asm.AssessmentID, asm.AssessmentName, asm.Description, asm.AssessDate, asm.CompanyID, asm.Takes, asm.Delay
	FROM   Assessment as asm
	WHERE  asm.CompanyID = 0 AND asm.Status = 2 
	AND ( @IsTrial = 0 OR asm.IsTrial = @IsTrial )
 	AND asm.AssessDate > @VisitDate 
END

-- TAKEN COMPANY ASSESSMENTS
IF @Status = 12
BEGIN
	SELECT asm.AssessmentID, asm.AssessmentName, asm.Description, asm.AssessDate, asm.CompanyID, asm.Takes, asm.Delay
	FROM   MemberAssess AS ma
	LEFT   OUTER JOIN Assessment AS asm ON (asm.AssessmentID = ma.AssessmentID)
	WHERE  asm.CompanyID = @CompanyID AND ma.MemberID = @MemberID
	AND ( @IsTrial = 0 OR asm.IsTrial = @IsTrial )
END

-- LIST TOTAL ACCESSIBLE COMPANY ASSESSMENTS
IF @Status = 11
BEGIN 
	SELECT asm.AssessmentID, asm.AssessmentName, asm.Description, asm.AssessDate, asm.CompanyID, asm.Takes, asm.Delay
	FROM Assessment as asm 
	WHERE asm.CompanyID = @CompanyID AND asm.Status = 2
	AND ( @IsTrial = 0 OR asm.IsTrial = @IsTrial )
END

-- LIST NEW COMPANY ASSESSMENTS FOR DATES
IF @Status = 10 OR @Status = 9
BEGIN
	SELECT asm.AssessmentID, asm.AssessmentName, asm.Description, asm.AssessDate, asm.CompanyID, asm.Takes, asm.Delay
	FROM   Assessment as asm
	WHERE  asm.CompanyID = @CompanyID AND asm.Status = 2 
	AND asm.AssessDate > @VisitDate
	AND ( @IsTrial = 0 OR asm.IsTrial = @IsTrial )
END


GO