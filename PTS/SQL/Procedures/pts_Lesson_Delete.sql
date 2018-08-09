EXEC [dbo].pts_CheckProc 'pts_Lesson_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Lesson_Delete ( 
   @LessonID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE le
FROM Lesson AS le
WHERE le.LessonID = @LessonID

GO