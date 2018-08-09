EXEC [dbo].pts_CheckProc 'pts_Session_Add'
 GO

CREATE PROCEDURE [dbo].pts_Session_Add ( 
   @SessionID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Session (
            MemberID , 
            CourseID , 
            OrgCourseID , 
            NameLast , 
            NameFirst , 
            Status , 
            RegisterDate , 
            StartDate , 
            CompleteDate , 
            Grade , 
            Feedback , 
            Rating1 , 
            Rating2 , 
            Rating3 , 
            Rating4 , 
            TotalRating , 
            URLOption , 
            Time , 
            Times , 
            IsInactive , 
            TrainerScore , 
            CommStatus , 
            Apply , 
            Recommend1 , 
            Recommend2 , 
            Recommend3
            )
VALUES (
            @MemberID ,
            @CourseID ,
            @OrgCourseID ,
            @NameLast ,
            @NameFirst ,
            @Status ,
            @RegisterDate ,
            @StartDate ,
            @CompleteDate ,
            @Grade ,
            @Feedback ,
            @Rating1 ,
            @Rating2 ,
            @Rating3 ,
            @Rating4 ,
            @TotalRating ,
            @URLOption ,
            @Time ,
            @Times ,
            @IsInactive ,
            @TrainerScore ,
            @CommStatus ,
            @Apply ,
            @Recommend1 ,
            @Recommend2 ,
            @Recommend3            )

SET @mNewID = @@IDENTITY

SET @SessionID = @mNewID

GO