EXEC [dbo].pts_CheckProc 'pts_Homework_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Homework_Fetch ( 
   @HomeworkID int,
   @LessonID int OUTPUT,
   @LessonName nvarchar (60) OUTPUT,
   @Name nvarchar (60) OUTPUT,
   @Description nvarchar (2000) OUTPUT,
   @Seq int OUTPUT,
   @Weight int OUTPUT,
   @IsGrade bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @LessonID = hw.LessonID ,
   @LessonName = le.LessonName ,
   @Name = hw.Name ,
   @Description = hw.Description ,
   @Seq = hw.Seq ,
   @Weight = hw.Weight ,
   @IsGrade = hw.IsGrade
FROM Homework AS hw (NOLOCK)
LEFT OUTER JOIN Lesson AS le (NOLOCK) ON (hw.LessonID = le.LessonID)
WHERE hw.HomeworkID = @HomeworkID

GO