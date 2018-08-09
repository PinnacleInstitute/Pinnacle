-- reset all Assessments for a member

DECLARE @MemberID int

SET @MemberID = 40618

DELETE aa
FROM AssessAnswer AS aa
JOIN MemberAssess AS ma ON aa.MemberAssessID = ma.MemberAssessID
WHERE ma.MemberID = @MemberID

UPDATE ma
SET CompleteDate = 0, Status = 0, Result = '', Score = 0 
FROM MemberAssess AS ma
WHERE ma.MemberID = @MemberID









