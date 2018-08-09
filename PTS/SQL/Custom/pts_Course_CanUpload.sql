EXEC [dbo].pts_CheckProc 'pts_Course_CanUpload'
GO

CREATE PROCEDURE [dbo].pts_Course_CanUpload
   @CourseID int ,
   @IsUpload bit OUTPUT
AS

SET NOCOUNT ON

SET @IsUpload = ISNULL((SELECT tr.IsUpload
	FROM Course AS co
	LEFT OUTER JOIN Trainer AS tr ON (tr.TrainerID = co.TrainerID)
	WHERE co.CourseID = @CourseID
	), 0)

GO
