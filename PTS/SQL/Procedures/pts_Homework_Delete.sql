EXEC [dbo].pts_CheckProc 'pts_Homework_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Homework_Delete ( 
   @HomeworkID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE hw
FROM Homework AS hw
WHERE hw.HomeworkID = @HomeworkID

GO