EXEC [dbo].pts_CheckProc 'pts_Course_Update'
GO

CREATE PROCEDURE [dbo].pts_Course_Update
   @CourseID int,
   @CourseCategoryID int,
   @TrainerID int,
   @CompanyID int,
   @ExamID int,
   @CourseName nvarchar (80),
   @Status int,
   @CourseType int,
   @CourseLevel int,
   @Description nvarchar (1000),
   @Language nvarchar (20),
   @CourseLength int,
   @CourseDate datetime,
   @IsPaid bit,
   @Price money,
   @Grp int,
   @Seq int,
   @PassingGrade int,
   @Rating int,
   @RatingCnt int,
   @Classes int,
   @Video bit,
   @Audio bit,
   @Quiz bit,
   @Reference varchar (15),
   @ScoreFactor decimal (10, 6),
   @NoCertificate bit,
   @NoEvaluation bit,
   @IsCustomCertificate bit,
   @Credit money,
   @ExamWeight int,
   @Pre varchar (20),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int, 
         @mOldStatus int, 
         @mOldCourseCategoryID int

SET NOCOUNT ON

SELECT @mOldStatus = Status, @mOldCourseCategoryID = CourseCategoryID FROM Course WHERE CourseID = @CourseID
SET @mNow = GETDATE()
IF ((@mOldStatus <> @Status))
   BEGIN
   EXEC pts_CourseCategory_Update_Counters
      @CourseCategoryID

   END

IF ((@mOldCourseCategoryID <> @CourseCategoryID))
   BEGIN
   EXEC pts_CourseCategory_Update_Counters
      @mOldCourseCategoryID

   EXEC pts_CourseCategory_Update_Counters
      @CourseCategoryID

   END

UPDATE cs
SET cs.CourseCategoryID = @CourseCategoryID ,
   cs.TrainerID = @TrainerID ,
   cs.CompanyID = @CompanyID ,
   cs.ExamID = @ExamID ,
   cs.CourseName = @CourseName ,
   cs.Status = @Status ,
   cs.CourseType = @CourseType ,
   cs.CourseLevel = @CourseLevel ,
   cs.Description = @Description ,
   cs.Language = @Language ,
   cs.CourseLength = @CourseLength ,
   cs.CourseDate = @CourseDate ,
   cs.IsPaid = @IsPaid ,
   cs.Price = @Price ,
   cs.Grp = @Grp ,
   cs.Seq = @Seq ,
   cs.PassingGrade = @PassingGrade ,
   cs.Rating = @Rating ,
   cs.RatingCnt = @RatingCnt ,
   cs.Classes = @Classes ,
   cs.Video = @Video ,
   cs.Audio = @Audio ,
   cs.Quiz = @Quiz ,
   cs.Reference = @Reference ,
   cs.ScoreFactor = @ScoreFactor ,
   cs.NoCertificate = @NoCertificate ,
   cs.NoEvaluation = @NoEvaluation ,
   cs.IsCustomCertificate = @IsCustomCertificate ,
   cs.Credit = @Credit ,
   cs.ExamWeight = @ExamWeight ,
   cs.Pre = @Pre
FROM Course AS cs
WHERE (cs.CourseID = @CourseID)


GO