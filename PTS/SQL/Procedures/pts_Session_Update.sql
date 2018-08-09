EXEC [dbo].pts_CheckProc 'pts_Session_Update'
 GO

CREATE PROCEDURE [dbo].pts_Session_Update ( 
   @SessionID int,
   @MemberID int,
   @CourseID int,
   @OrgCourseID int,
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Status int,
   @RegisterDate datetime,
   @StartDate datetime,
   @CompleteDate datetime,
   @Grade int,
   @Feedback nvarchar (2000),
   @Rating1 int,
   @Rating2 int,
   @Rating3 int,
   @Rating4 int,
   @TotalRating int,
   @URLOption int,
   @Time int,
   @Times decimal (10, 8),
   @IsInactive bit,
   @TrainerScore int,
   @CommStatus int,
   @Apply int,
   @Recommend1 int,
   @Recommend2 int,
   @Recommend3 int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE se
SET se.MemberID = @MemberID ,
   se.CourseID = @CourseID ,
   se.OrgCourseID = @OrgCourseID ,
   se.NameLast = @NameLast ,
   se.NameFirst = @NameFirst ,
   se.Status = @Status ,
   se.RegisterDate = @RegisterDate ,
   se.StartDate = @StartDate ,
   se.CompleteDate = @CompleteDate ,
   se.Grade = @Grade ,
   se.Feedback = @Feedback ,
   se.Rating1 = @Rating1 ,
   se.Rating2 = @Rating2 ,
   se.Rating3 = @Rating3 ,
   se.Rating4 = @Rating4 ,
   se.TotalRating = @TotalRating ,
   se.URLOption = @URLOption ,
   se.Time = @Time ,
   se.Times = @Times ,
   se.IsInactive = @IsInactive ,
   se.TrainerScore = @TrainerScore ,
   se.CommStatus = @CommStatus ,
   se.Apply = @Apply ,
   se.Recommend1 = @Recommend1 ,
   se.Recommend2 = @Recommend2 ,
   se.Recommend3 = @Recommend3
FROM Session AS se
WHERE se.SessionID = @SessionID

GO