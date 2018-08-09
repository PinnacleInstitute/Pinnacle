EXEC [dbo].pts_CheckProc 'pts_Question_List'
GO

CREATE PROCEDURE [dbo].pts_Question_List
   @QuestionTypeID int ,
   @Secure int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      qu.QuestionID, 
         qu.Question, 
         qu.Answer, 
         qu.QuestionDate
FROM Question AS qu (NOLOCK)
WHERE (qu.QuestionTypeID = @QuestionTypeID)
 AND (qu.Secure <= @Secure)
 AND (qu.Status = 2)

ORDER BY   qu.Seq

GO