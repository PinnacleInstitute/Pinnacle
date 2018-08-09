EXEC [dbo].pts_CheckProc 'pts_MemberAssess_CertifyLookup'
GO

--EXEC pts_MemberAssess_CertifyLookup 20, '', 1

CREATE PROCEDURE [dbo].pts_MemberAssess_CertifyLookup
   @MemberID int ,
   @MemberName varchar(15) ,
   @AssessmentID int 
AS

SET NOCOUNT ON
DECLARE @Reference varchar(15)
SET @Reference = @MemberName

IF @MemberID > 0
BEGIN
	SELECT ma.MemberAssessID, 
	       ma.AssessmentID,
	       am.AssessmentName AS 'AssessmentName', 
	       ma.CompleteDate, 
	       ma.Result, 
	       am.Grade AS 'Num1', 
	       ma.Status
	FROM MemberAssess as ma
	JOIN Assessment AS am ON ma.AssessmentID = am.AssessmentID 
	WHERE ma.MemberID = @MemberID
	AND   ma.AssessmentID = @AssessmentID
	ORDER BY ma.CompleteDate DESC
END
IF @MemberID = 0 AND @Reference != ''
BEGIN
	SELECT ma.MemberAssessID, 
	       ma.AssessmentID,
	       am.AssessmentName AS 'AssessmentName', 
	       ma.CompleteDate, 
	       ma.Result, 
	       am.Grade AS 'Num1', 
	       ma.Status
	FROM MemberAssess as ma
	JOIN Assessment AS am ON ma.AssessmentID = am.AssessmentID 
	JOIN Member AS me ON ma.MemberID = me.MemberID 
	WHERE me.Reference = @Reference
	AND   ma.AssessmentID = @AssessmentID
	ORDER BY ma.CompleteDate DESC
END

GO