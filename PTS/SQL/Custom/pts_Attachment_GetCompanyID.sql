EXEC [dbo].pts_CheckProc 'pts_Attachment_GetCompanyID'
GO

CREATE PROCEDURE [dbo].pts_Attachment_GetCompanyID
   @ParentType int,
   @ParentID int,
   @Result int OUTPUT
AS

SET @Result = 0

IF @ParentType = 4
BEGIN
	SELECT @Result = CompanyID
	FROM Member WHERE MemberID = @ParentID
END
IF @ParentType = 23
BEGIN
	SELECT @Result = co.CompanyID
	FROM Lesson AS le
	JOIN Course AS co ON le.CourseID = co.CourseID
	WHERE le.LessonID = @ParentID
END
IF @ParentType = 24
BEGIN
	SELECT @Result = co.CompanyID
	FROM SessionLesson AS sl
	JOIN Lesson AS le ON sl.LessonID = le.LessonID
	JOIN Course AS co ON le.CourseID = co.CourseID
	WHERE sl.SessionLessonID = @ParentID
END
IF @ParentType = 28
BEGIN
	SELECT @Result = CompanyID
	FROM Org WHERE OrgID = @ParentID
END
IF @ParentType = 38
BEGIN
	SELECT @Result = @ParentID
END
IF @ParentType = 64
BEGIN
	SELECT me.CompanyID
	FROM Expense AS ex
	JOIN Member AS me ON ex.MemberID = me.MemberID
	WHERE ex.ExpenseID = 1
END
IF @ParentType = 74
BEGIN
	SELECT @Result = pr.CompanyID
	FROM Task AS ta
	JOIN Project AS pr ON ta.ProjectID = pr.ProjectID
	WHERE ta.TaskID = @ParentID
END
IF @ParentType = 75
BEGIN
	SELECT @Result = CompanyID
	FROM Project WHERE ProjectID = @ParentID
END
IF @ParentType = 81
BEGIN
	SELECT @Result = CompanyID
	FROM Prospect WHERE ProspectID = @ParentID
END
IF @ParentType = -81
BEGIN
	SELECT @Result = CompanyID
	FROM Prospect WHERE ProspectID = @ParentID
END

GO