EXEC [dbo].pts_CheckProc 'pts_SessionLesson_Delete'
GO

CREATE PROCEDURE [dbo].pts_SessionLesson_Delete
   @SessionLessonID int,
   @UserID int
AS

SET NOCOUNT ON

DELETE sl
FROM SessionLesson AS sl
WHERE (sl.SessionLessonID = @SessionLessonID)


GO