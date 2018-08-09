EXEC [dbo].pts_CheckProc 'pts_QuestionType_List'
GO

CREATE PROCEDURE [dbo].pts_QuestionType_List
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      qtl.QuestionTypeID, 
         qtl.QuestionTypeName, 
         qtl.Seq, 
         qtl.UserType, 
         qtl.Secure
FROM QuestionType AS qtl (NOLOCK)
WHERE (qtl.CompanyID = @CompanyID)

ORDER BY   qtl.UserType , qtl.Seq

GO