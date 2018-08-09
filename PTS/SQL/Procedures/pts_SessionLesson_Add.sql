EXEC [dbo].pts_CheckProc 'pts_SessionLesson_Add'
 GO

CREATE PROCEDURE [dbo].pts_SessionLesson_Add ( 
   @SessionLessonID int OUTPUT,
   @SessionID int,
   @LessonID int,
   @Status int,
   @QuizScore int,
   @CreateDate datetime,
   @CompleteDate datetime,
   @Time int,
   @Times int,
   @Questions nvarchar (200),
   @Location nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO SessionLesson (
            SessionID , 
            LessonID , 
            Status , 
            QuizScore , 
            CreateDate , 
            CompleteDate , 
            Time , 
            Times , 
            Questions , 
            Location
            )
VALUES (
            @SessionID ,
            @LessonID ,
            @Status ,
            @QuizScore ,
            @CreateDate ,
            @CompleteDate ,
            @Time ,
            @Times ,
            @Questions ,
            @Location            )

SET @mNewID = @@IDENTITY

SET @SessionLessonID = @mNewID

GO