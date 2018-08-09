EXEC [dbo].pts_CheckProc 'pts_OrgCourse_Update_Counters'
GO

CREATE PROCEDURE [dbo].pts_OrgCourse_Update_Counters
   @OrgCourseID int,
   @Amount int,
   @UserID int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Hierarchy varchar(100)

SELECT @CompanyID = CompanyID, @Hierarchy = Hierarchy
FROM Org AS oo JOIN OrgCourse AS oc ON oc.OrgID = oo.OrgID
WHERE oc.OrgCourseID = @OrgCourseID

IF @CompanyID > 0 AND @Hierarchy <> ''
BEGIN
	UPDATE Org SET CourseCount = (CourseCount + @Amount) 
	WHERE CompanyID = @CompanyID AND @Hierarchy LIKE Hierarchy + '%'
END

GO