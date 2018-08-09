EXEC [dbo].pts_CheckProc 'pts_MemberAssess_CalcResultType'
GO

--DECLARE @Courses varchar (50) EXEC pts_MemberAssess_GetCourses 53, @Courses OUTPUT PRINT @Courses

CREATE PROCEDURE [dbo].pts_MemberAssess_CalcResultType
   @MemberAssessID int ,
   @ResultPoints int OUTPUT
AS

SET NOCOUNT ON

DECLARE @ResultType int, @Answer int, @Points int, @AssessAnswer int

SET @ResultPoints = 0

DECLARE AssessQuestion_Cursor CURSOR FOR 
SELECT aq.ResultType, aq.Answer, aq.Points, aa.Answer FROM AssessAnswer AS aa
LEFT JOIN AssessQuestion AS aq ON aa.AssessQuestionID = aq.AssessQuestionID
WHERE aa.MemberAssessID = @MemberAssessID AND aq.ResultType <> 0

OPEN AssessQuestion_Cursor

FETCH NEXT FROM AssessQuestion_Cursor INTO @ResultType, @Answer, @Points, @AssessAnswer

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @ResultType = 1
	BEGIN
		IF @Answer = @AssessAnswer SET @ResultPoints = @ResultPoints + @Points
	END

	FETCH NEXT FROM AssessQuestion_Cursor INTO @ResultType, @Answer, @Points, @AssessAnswer
END

CLOSE AssessQuestion_Cursor
DEALLOCATE AssessQuestion_Cursor


GO