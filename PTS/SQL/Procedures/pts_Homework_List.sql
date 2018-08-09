EXEC [dbo].pts_CheckProc 'pts_Homework_List'
GO

CREATE PROCEDURE [dbo].pts_Homework_List
   @LessonID int
AS

SET NOCOUNT ON

SELECT      hw.HomeworkID, 
         hw.Name, 
         hw.Description, 
         hw.Seq, 
         hw.Weight, 
         hw.IsGrade
FROM Homework AS hw (NOLOCK)
WHERE (hw.LessonID = @LessonID)

ORDER BY   hw.Seq

GO