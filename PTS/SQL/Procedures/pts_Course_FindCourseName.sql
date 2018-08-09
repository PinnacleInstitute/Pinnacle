EXEC [dbo].pts_CheckProc 'pts_Course_FindCourseName'
 GO

CREATE PROCEDURE [dbo].pts_Course_FindCourseName ( 
   @SearchText nvarchar (80),
   @Bookmark nvarchar (90),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(cs.CourseName, '') + dbo.wtfn_FormatNumber(cs.CourseID, 10) 'BookMark' ,
            cs.CourseID 'CourseID' ,
            cs.CourseCategoryID 'CourseCategoryID' ,
            cs.TrainerID 'TrainerID' ,
            cs.CompanyID 'CompanyID' ,
            cs.ExamID 'ExamID' ,
            cc.CourseCategoryName 'CourseCategoryName' ,
            tr.CompanyName 'TrainerName' ,
            cs.CourseName 'CourseName' ,
            cs.Status 'Status' ,
            cs.CourseType 'CourseType' ,
            cs.CourseLevel 'CourseLevel' ,
            cs.Description 'Description' ,
            cs.Language 'Language' ,
            cs.CourseLength 'CourseLength' ,
            cs.CourseDate 'CourseDate' ,
            cs.IsPaid 'IsPaid' ,
            cs.Price 'Price' ,
            cs.Grp 'Grp' ,
            cs.Seq 'Seq' ,
            cs.PassingGrade 'PassingGrade' ,
            cs.Rating 'Rating' ,
            cs.RatingCnt 'RatingCnt' ,
            cs.Classes 'Classes' ,
            cs.Video 'Video' ,
            cs.Audio 'Audio' ,
            cs.Quiz 'Quiz' ,
            cs.Reference 'Reference' ,
            cs.ScoreFactor 'ScoreFactor' ,
            cs.NoCertificate 'NoCertificate' ,
            cs.NoEvaluation 'NoEvaluation' ,
            cs.IsCustomCertificate 'IsCustomCertificate' ,
            cs.Credit 'Credit' ,
            cs.ExamWeight 'ExamWeight' ,
            cs.Pre 'Pre'
FROM Course AS cs (NOLOCK)
LEFT OUTER JOIN CourseCategory AS cc (NOLOCK) ON (cs.CourseCategoryID = cc.CourseCategoryID)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE ISNULL(cs.CourseName, '') LIKE '%' + @SearchText + '%'
AND ISNULL(cs.CourseName, '') + dbo.wtfn_FormatNumber(cs.CourseID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO