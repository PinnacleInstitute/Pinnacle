EXEC [dbo].pts_CheckProc 'pts_Course_Decrement_Counters'
GO

CREATE PROCEDURE [dbo].pts_Course_Decrement_Counters
   @CourseID int,
   @UserID int
AS

SET NOCOUNT ON

DECLARE @CourseCategoryID int, @OrgID int

SELECT @CourseCategoryID = CourseCategoryID, @OrgID = CompanyID
FROM Course 
WHERE CourseID = @CourseID

EXEC pts_Course_Update_Counters @CourseCategoryID, @OrgID, -1, @UserID

GO