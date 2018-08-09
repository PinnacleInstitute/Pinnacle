EXEC [dbo].pts_CheckProc 'pts_QuestionType_Delete'
 GO

CREATE PROCEDURE [dbo].pts_QuestionType_Delete ( 
   @QuestionTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE qtl
FROM QuestionType AS qtl
WHERE qtl.QuestionTypeID = @QuestionTypeID

GO