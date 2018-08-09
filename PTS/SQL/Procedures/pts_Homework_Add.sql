EXEC [dbo].pts_CheckProc 'pts_Homework_Add'
 GO

CREATE PROCEDURE [dbo].pts_Homework_Add ( 
   @HomeworkID int OUTPUT,
   @LessonID int,
   @Name nvarchar (60),
   @Description nvarchar (2000),
   @Seq int,
   @Weight int,
   @IsGrade bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Homework (
            LessonID , 
            Name , 
            Description , 
            Seq , 
            Weight , 
            IsGrade
            )
VALUES (
            @LessonID ,
            @Name ,
            @Description ,
            @Seq ,
            @Weight ,
            @IsGrade            )

SET @mNewID = @@IDENTITY

SET @HomeworkID = @mNewID

GO