EXEC [dbo].pts_CheckProc 'pts_Question_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Question_Fetch ( 
   @QuestionID int,
   @CompanyID int OUTPUT,
   @QuestionTypeID int OUTPUT,
   @QuestionTypeName nvarchar (60) OUTPUT,
   @UserType int OUTPUT,
   @QuestionDate datetime OUTPUT,
   @Question nvarchar (200) OUTPUT,
   @Answer nvarchar (4000) OUTPUT,
   @Reference nvarchar (30) OUTPUT,
   @Seq int OUTPUT,
   @Status int OUTPUT,
   @Secure int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = qu.CompanyID ,
   @QuestionTypeID = qu.QuestionTypeID ,
   @QuestionTypeName = qtl.QuestionTypeName ,
   @UserType = qtl.UserType ,
   @QuestionDate = qu.QuestionDate ,
   @Question = qu.Question ,
   @Answer = qu.Answer ,
   @Reference = qu.Reference ,
   @Seq = qu.Seq ,
   @Status = qu.Status ,
   @Secure = qu.Secure
FROM Question AS qu (NOLOCK)
LEFT OUTER JOIN QuestionType AS qtl (NOLOCK) ON (qu.QuestionTypeID = qtl.QuestionTypeID)
WHERE qu.QuestionID = @QuestionID

GO