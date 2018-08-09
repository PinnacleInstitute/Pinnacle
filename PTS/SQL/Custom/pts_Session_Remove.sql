EXEC [dbo].pts_CheckProc 'pts_Session_Remove'
GO

CREATE PROCEDURE [dbo].pts_Session_Remove
   @SessionID int ,
   @MemberID int OUTPUT
AS

SET NOCOUNT ON

UPDATE Session SET IsInactive = 1 WHERE SessionID = @SessionID

--DELETE      qa
--FROM        QuizAnswer AS qa
--            LEFT OUTER JOIN SessionLesson AS sl ON (qa.SessionLessonID = sl.SessionLessonID)
--WHERE       sl.SessionID = @SessionID
--
--DELETE      sl
--FROM        SessionLesson AS sl
--WHERE       sl.SessionID = @SessionID
--
--DELETE      s
--FROM        Session AS s
--WHERE       s.SessionID = @SessionID

SET @MemberID = 1

GO
