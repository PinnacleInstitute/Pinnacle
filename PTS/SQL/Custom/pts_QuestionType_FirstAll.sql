EXEC [dbo].pts_CheckProc 'pts_QuestionType_FirstAll'
GO

CREATE PROCEDURE [dbo].pts_QuestionType_FirstAll
   @CompanyID int ,
   @Secure int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

SELECT TOP 1  @Result = QuestionTypeID 
FROM QuestionType (NOLOCK)
WHERE (CompanyID = @CompanyID) AND (Secure <= @Secure)
ORDER BY Seq

IF @Result IS NULL SET @Result = 0

GO