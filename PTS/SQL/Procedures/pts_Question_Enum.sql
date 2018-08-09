EXEC [dbo].pts_CheckProc 'pts_Question_Enum'
 GO

CREATE PROCEDURE [dbo].pts_Question_Enum ( 
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT         qu.QuestionID 'ID' ,
            qu.Question 'Name'
FROM Question AS qu (NOLOCK)
ORDER BY qu.Question

GO