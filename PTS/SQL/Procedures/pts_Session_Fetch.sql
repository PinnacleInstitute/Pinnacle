EXEC [dbo].pts_CheckProc 'pts_Session_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Session_Fetch ( 
   @SessionID int,
   @MemberID int OUTPUT,
   @CourseID int OUTPUT,
   @OrgCourseID int OUTPUT,
   @CourseName nvarchar (60) OUTPUT,
   @CourseLength int OUTPUT,
   @PassingGrade int OUTPUT,
   @Video int OUTPUT,
   @Audio int OUTPUT,
   @Quiz int OUTPUT,
   @MemberName nvarchar (60) OUTPUT,
   @QuizLimit int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @StudentName nvarchar (62) OUTPUT,
   @Status int OUTPUT,
   @RegisterDate datetime OUTPUT,
   @StartDate datetime OUTPUT,
   @CompleteDate datetime OUTPUT,
   @Grade int OUTPUT,
   @Feedback nvarchar (2000) OUTPUT,
   @Rating1 int OUTPUT,
   @Rating2 int OUTPUT,
   @Rating3 int OUTPUT,
   @Rating4 int OUTPUT,
   @TotalRating int OUTPUT,
   @URLOption int OUTPUT,
   @Time int OUTPUT,
   @Times decimal (10, 8) OUTPUT,
   @IsInactive bit OUTPUT,
   @TrainerScore int OUTPUT,
   @CommStatus int OUTPUT,
   @Apply int OUTPUT,
   @Recommend1 int OUTPUT,
   @Recommend2 int OUTPUT,
   @Recommend3 int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = se.MemberID ,
   @CourseID = se.CourseID ,
   @OrgCourseID = se.OrgCourseID ,
   @CourseName = cs.CourseName ,
   @CourseLength = cs.CourseLength ,
   @PassingGrade = cs.PassingGrade ,
   @Video = cs.Video ,
   @Audio = cs.Audio ,
   @Quiz = cs.Quiz ,
   @MemberName = me.CompanyName ,
   @QuizLimit = me.QuizLimit ,
   @NameLast = se.NameLast ,
   @NameFirst = se.NameFirst ,
   @StudentName = LTRIM(RTRIM(se.NameFirst)) +  ' '  + LTRIM(RTRIM(se.NameLast)) ,
   @Status = se.Status ,
   @RegisterDate = se.RegisterDate ,
   @StartDate = se.StartDate ,
   @CompleteDate = se.CompleteDate ,
   @Grade = se.Grade ,
   @Feedback = se.Feedback ,
   @Rating1 = se.Rating1 ,
   @Rating2 = se.Rating2 ,
   @Rating3 = se.Rating3 ,
   @Rating4 = se.Rating4 ,
   @TotalRating = se.TotalRating ,
   @URLOption = se.URLOption ,
   @Time = se.Time ,
   @Times = se.Times ,
   @IsInactive = se.IsInactive ,
   @TrainerScore = se.TrainerScore ,
   @CommStatus = se.CommStatus ,
   @Apply = se.Apply ,
   @Recommend1 = se.Recommend1 ,
   @Recommend2 = se.Recommend2 ,
   @Recommend3 = se.Recommend3
FROM Session AS se (NOLOCK)
LEFT OUTER JOIN Course AS cs (NOLOCK) ON (se.CourseID = cs.CourseID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (se.MemberID = me.MemberID)
WHERE se.SessionID = @SessionID

GO