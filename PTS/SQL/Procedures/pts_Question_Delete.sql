EXEC [dbo].pts_CheckProc 'pts_Question_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Question_Delete ( 
   @QuestionID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE qu
FROM Question AS qu
WHERE qu.QuestionID = @QuestionID

GO