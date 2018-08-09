EXEC [dbo].pts_CheckProc 'pts_OrgCourse_Add'
GO

CREATE PROCEDURE [dbo].pts_OrgCourse_Add
   @OrgCourseID int OUTPUT,
   @OrgID int,
   @CourseID int,
   @Status int,
   @QuizLimit int,
   @Seq int,
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
INSERT INTO OrgCourse (
            OrgID , 
            CourseID , 
            Status , 
            QuizLimit , 
            Seq

            )
VALUES (
            @OrgID ,
            @CourseID ,
            @Status ,
            @QuizLimit ,
            @Seq
            )

SET @mNewID = @@IDENTITY
SET @OrgCourseID = @mNewID
EXEC pts_OrgCourse_Update_Counters
   @OrgCourseID ,
   1 ,
   @UserID

GO