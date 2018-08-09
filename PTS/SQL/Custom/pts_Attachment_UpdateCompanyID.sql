EXEC [dbo].pts_CheckProc 'pts_Attachment_UpdateCompanyID'
GO

CREATE PROCEDURE [dbo].pts_Attachment_UpdateCompanyID
   @ParentType int,
   @ParentID int,
   @CompanyID int,
   @Result int OUTPUT
AS

SET @Result = 0

IF @ParentType = 23
BEGIN
	DECLARE @CourseID int
	SET @CourseID = @ParentID

	UPDATE att SET CompanyID = @CompanyID
	FROM Attachment AS att
	JOIN Lesson AS le ON (le.LessonID = att.ParentID AND ParentType=23)
	WHERE le.CourseID = @CourseID
END

GO