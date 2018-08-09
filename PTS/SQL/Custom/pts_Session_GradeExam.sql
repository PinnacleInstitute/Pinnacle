EXEC [dbo].pts_CheckProc 'pts_Session_GradeExam'
GO

--EXEC pts_Session_GradeExam 1, 84

CREATE PROCEDURE [dbo].pts_Session_GradeExam
   @AssessmentID int ,
   @MemberID int
AS

SET NOCOUNT ON

DECLARE @SessionID int

DECLARE Session_cursor CURSOR LOCAL STATIC FOR 
-- lookup all registered courses for this Session that use this exam
SELECT se.SessionID
FROM Session AS se
JOIN Course AS co ON se.CourseID = co.CourseID
WHERE se.MemberID = @MemberID AND co.ExamID = @AssessmentID

OPEN Session_cursor
FETCH NEXT FROM Session_cursor INTO @SessionID

WHILE @@FETCH_STATUS = 0
BEGIN
-- 	-- calculate the grade for this session
print CAST(@SessionID as varchar(10))
	EXEC pts_Session_SetStatus @SessionID, '', @MemberID
	FETCH NEXT FROM Session_cursor INTO @SessionID
END
CLOSE Session_cursor
DEALLOCATE Session_cursor

GO

