EXEC [dbo].pts_CheckProc 'pts_Assessment_FindAssessmentName'
 GO

CREATE PROCEDURE [dbo].pts_Assessment_FindAssessmentName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(asm.AssessmentName, '') + dbo.wtfn_FormatNumber(asm.AssessmentID, 10) 'BookMark' ,
            asm.AssessmentID 'AssessmentID' ,
            asm.TrainerID 'TrainerID' ,
            asm.CompanyID 'CompanyID' ,
            asm.FirstQuestionCode 'FirstQuestionCode' ,
            asm.AssessmentName 'AssessmentName' ,
            asm.Description 'Description' ,
            asm.Courses 'Courses' ,
            asm.Assessments 'Assessments' ,
            asm.AssessDate 'AssessDate' ,
            asm.Status 'Status' ,
            asm.AssessmentType 'AssessmentType' ,
            asm.NewURL 'NewURL' ,
            asm.EditURL 'EditURL' ,
            asm.ResultType 'ResultType' ,
            asm.Formula 'Formula' ,
            asm.CustomCode 'CustomCode' ,
            asm.Takes 'Takes' ,
            asm.Delay 'Delay' ,
            asm.IsTrial 'IsTrial' ,
            asm.IsPaid 'IsPaid' ,
            asm.IsCertify 'IsCertify' ,
            asm.AssessType 'AssessType' ,
            asm.AssessLevel 'AssessLevel' ,
            asm.AssessLength 'AssessLength' ,
            asm.ScoreFactor 'ScoreFactor' ,
            asm.Rating 'Rating' ,
            asm.Grade 'Grade' ,
            asm.Points 'Points' ,
            asm.TimeLimit 'TimeLimit' ,
            asm.NoCertificate 'NoCertificate' ,
            asm.IsCustomCertificate 'IsCustomCertificate'
FROM Assessment AS asm (NOLOCK)
WHERE ISNULL(asm.AssessmentName, '') LIKE @SearchText + '%'
AND ISNULL(asm.AssessmentName, '') + dbo.wtfn_FormatNumber(asm.AssessmentID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO