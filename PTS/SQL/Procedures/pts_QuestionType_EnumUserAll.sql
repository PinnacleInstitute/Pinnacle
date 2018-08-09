EXEC [dbo].pts_CheckProc 'pts_QuestionType_EnumUserAll'
GO

CREATE PROCEDURE [dbo].pts_QuestionType_EnumUserAll
   @CompanyID int ,
   @Secure int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      qtl.QuestionTypeID AS 'ID', 
         qtl.QuestionTypeName AS 'Name'
FROM QuestionType AS qtl (NOLOCK)
WHERE (qtl.CompanyID = @CompanyID)
 AND (qtl.Secure <= @Secure)

ORDER BY   qtl.Seq

GO