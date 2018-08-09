EXEC [dbo].pts_CheckProc 'pts_Question_FindQuestionDate'
 GO

CREATE PROCEDURE [dbo].pts_Question_FindQuestionDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), qu.QuestionDate, 112), '') + dbo.wtfn_FormatNumber(qu.QuestionID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), qu.QuestionDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), qu.QuestionDate, 112), '') + dbo.wtfn_FormatNumber(qu.QuestionID, 10) <= @BookMark
AND         (qu.CompanyID = @CompanyID)
ORDER BY 'Bookmark' DESC

GO