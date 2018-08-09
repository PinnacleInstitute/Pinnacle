EXEC [dbo].pts_CheckProc 'pts_Question_FindStatusQuestionTypeName'
 GO

CREATE PROCEDURE [dbo].pts_Question_FindStatusQuestionTypeName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(qtl.QuestionTypeName, '') + dbo.wtfn_FormatNumber(qu.QuestionID, 10) 'BookMark' ,
            qu.QuestionID 'QuestionID' ,
            qu.CompanyID 'CompanyID' ,
            qu.QuestionTypeID 'QuestionTypeID' ,
            qtl.QuestionTypeName 'QuestionTypeName' ,
            qtl.UserType 'UserType' ,
            qu.QuestionDate 'QuestionDate' ,
            qu.Question 'Question' ,
            qu.Answer 'Answer' ,
            qu.Reference 'Reference' ,
            qu.Seq 'Seq' ,
            qu.Status 'Status' ,
            qu.Secure 'Secure'
FROM Question AS qu (NOLOCK)
LEFT OUTER JOIN QuestionType AS qtl (NOLOCK) ON (qu.QuestionTypeID = qtl.QuestionTypeID)
WHERE ISNULL(qtl.QuestionTypeName, '') LIKE @SearchText + '%'
AND ISNULL(qtl.QuestionTypeName, '') + dbo.wtfn_FormatNumber(qu.QuestionID, 10) >= @BookMark
AND         (qu.CompanyID = @CompanyID)
AND         (qu.Status = @Status)
ORDER BY 'Bookmark'

GO