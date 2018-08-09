EXEC [dbo].pts_CheckProc 'pts_MemberAssess_CertifyMember'
GO

--EXEC pts_MemberAssess_CertifyMember 84, '1/1/2000', '1/1/06'

CREATE PROCEDURE [dbo].pts_MemberAssess_CertifyMember
   @MemberID int ,
   @StartDate datetime ,
   @CompleteDate datetime 
AS

SET NOCOUNT ON

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
--AND am.IsCertify = 1
AND ma.CompleteDate >= @StartDate
AND ma.CompleteDate <= @CompleteDate
ORDER BY ma.CompleteDate
GO