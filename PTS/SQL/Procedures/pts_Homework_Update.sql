EXEC [dbo].pts_CheckProc 'pts_Homework_Update'
 GO

CREATE PROCEDURE [dbo].pts_Homework_Update ( 
   @HomeworkID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE hw
SET hw.LessonID = @LessonID ,
   hw.Name = @Name ,
   hw.Description = @Description ,
   hw.Seq = @Seq ,
   hw.Weight = @Weight ,
   hw.IsGrade = @IsGrade
FROM Homework AS hw
WHERE hw.HomeworkID = @HomeworkID

GO