EXEC [dbo].pts_CheckProc 'pts_SessionLesson_GetSessionLesson'
GO

CREATE PROCEDURE [dbo].pts_SessionLesson_GetSessionLesson
   @SessionID int ,
   @LessonID int ,
   @UserID int ,
   @SessionLessonID int OUTPUT
AS

DECLARE @mSessionLessonID int

SET NOCOUNT ON

SELECT      @mSessionLessonID = sl.SessionLessonID
FROM SessionLesson AS sl (NOLOCK)
WHERE (sl.SessionID = @SessionID)
 AND (sl.LessonID = @LessonID)


SET @SessionLessonID = ISNULL(@mSessionLessonID, 0)
GO