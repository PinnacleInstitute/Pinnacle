EXEC [dbo].pts_CheckProc 'pts_Course_SetContent'
GO

CREATE PROCEDURE [dbo].pts_Course_SetContent
   @CourseID int ,
   @TrainerID int OUTPUT
AS

SET NOCOUNT ON

DECLARE @video int, @audio int, @quiz int

-- Get the content for the course lessons
SELECT @video = COUNT(*) FROM Lesson WHERE CourseID = @CourseID AND MediaType = 1
SELECT @audio = COUNT(*) FROM Lesson WHERE CourseID = @CourseID AND MediaType = 2
SELECT @quiz = COUNT(*) FROM Lesson WHERE CourseID = @CourseID AND Quiz > 1

UPDATE Course SET Video = @video, Audio = @audio, Quiz = @quiz WHERE CourseID = @CourseID

GO
