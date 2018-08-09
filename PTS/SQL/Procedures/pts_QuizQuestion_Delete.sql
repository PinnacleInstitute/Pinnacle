EXEC [dbo].pts_CheckProc 'pts_QuizQuestion_Delete'
 GO

CREATE PROCEDURE [dbo].pts_QuizQuestion_Delete ( 
   @QuizQuestionID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE qq
FROM QuizQuestion AS qq
WHERE qq.QuizQuestionID = @QuizQuestionID

GO