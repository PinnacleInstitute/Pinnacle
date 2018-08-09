EXEC [dbo].pts_CheckProc 'pts_Course_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Course_Fetch ( 
   @CourseID int,
   @CourseCategoryID int OUTPUT,
   @TrainerID int OUTPUT,
   @CompanyID int OUTPUT,
   @ExamID int OUTPUT,
   @CourseCategoryName nvarchar (60) OUTPUT,
   @TrainerName nvarchar (60) OUTPUT,
   @CourseName nvarchar (80) OUTPUT,
   @Status int OUTPUT,
   @CourseType int OUTPUT,
   @CourseLevel int OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @Language nvarchar (20) OUTPUT,
   @CourseLength int OUTPUT,
   @CourseDate datetime OUTPUT,
   @IsPaid bit OUTPUT,
   @Price money OUTPUT,
   @Grp int OUTPUT,
   @Seq int OUTPUT,
   @PassingGrade int OUTPUT,
   @Rating int OUTPUT,
   @RatingCnt int OUTPUT,
   @Classes int OUTPUT,
   @Video bit OUTPUT,
   @Audio bit OUTPUT,
   @Quiz bit OUTPUT,
   @Reference varchar (15) OUTPUT,
   @ScoreFactor decimal (10, 6) OUTPUT,
   @NoCertificate bit OUTPUT,
   @NoEvaluation bit OUTPUT,
   @IsCustomCertificate bit OUTPUT,
   @Credit money OUTPUT,
   @ExamWeight int OUTPUT,
   @Pre varchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CourseCategoryID = cs.CourseCategoryID ,
   @TrainerID = cs.TrainerID ,
   @CompanyID = cs.CompanyID ,
   @ExamID = cs.ExamID ,
   @CourseCategoryName = cc.CourseCategoryName ,
   @TrainerName = tr.CompanyName ,
   @CourseName = cs.CourseName ,
   @Status = cs.Status ,
   @CourseType = cs.CourseType ,
   @CourseLevel = cs.CourseLevel ,
   @Description = cs.Description ,
   @Language = cs.Language ,
   @CourseLength = cs.CourseLength ,
   @CourseDate = cs.CourseDate ,
   @IsPaid = cs.IsPaid ,
   @Price = cs.Price ,
   @Grp = cs.Grp ,
   @Seq = cs.Seq ,
   @PassingGrade = cs.PassingGrade ,
   @Rating = cs.Rating ,
   @RatingCnt = cs.RatingCnt ,
   @Classes = cs.Classes ,
   @Video = cs.Video ,
   @Audio = cs.Audio ,
   @Quiz = cs.Quiz ,
   @Reference = cs.Reference ,
   @ScoreFactor = cs.ScoreFactor ,
   @NoCertificate = cs.NoCertificate ,
   @NoEvaluation = cs.NoEvaluation ,
   @IsCustomCertificate = cs.IsCustomCertificate ,
   @Credit = cs.Credit ,
   @ExamWeight = cs.ExamWeight ,
   @Pre = cs.Pre
FROM Course AS cs (NOLOCK)
LEFT OUTER JOIN CourseCategory AS cc (NOLOCK) ON (cs.CourseCategoryID = cc.CourseCategoryID)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE cs.CourseID = @CourseID

GO