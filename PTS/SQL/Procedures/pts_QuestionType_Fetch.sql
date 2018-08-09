EXEC [dbo].pts_CheckProc 'pts_QuestionType_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_QuestionType_Fetch ( 
   @QuestionTypeID int,
   @CompanyID int OUTPUT,
   @QuestionTypeName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @UserType int OUTPUT,
   @Secure int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = qtl.CompanyID ,
   @QuestionTypeName = qtl.QuestionTypeName ,
   @Seq = qtl.Seq ,
   @UserType = qtl.UserType ,
   @Secure = qtl.Secure
FROM QuestionType AS qtl (NOLOCK)
WHERE qtl.QuestionTypeID = @QuestionTypeID

GO