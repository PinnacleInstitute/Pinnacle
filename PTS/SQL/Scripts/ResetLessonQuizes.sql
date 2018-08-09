-- reset all course lesson quizzes for a member

DECLARE @MemberID int

SET @MemberID = 0

DELETE qa 
FROM QuizAnswer as qa
JOIN SessionLesson AS sl ON qa.SessionLessonID = sl.SessionLessonID
JOIN Session AS se ON sl.SessionID = se.SessionID
WHERE se.MemberID = @MemberID

UPDATE sl 
SET Status = 0, QuizScore = 0, CompleteDate = 0, Time = 0, Times = 0, Questions = '', Location = ''  
FROM SessionLesson AS sl
JOIN Session AS se ON sl.SessionID = se.SessionID
WHERE se.MemberID = @MemberID










