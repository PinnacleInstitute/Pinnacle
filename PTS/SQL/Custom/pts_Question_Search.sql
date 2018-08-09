EXEC [dbo].pts_CheckProc 'pts_Question_Search'
 GO

--DECLARE @MaxRows tinyint EXEC pts_Question_Search 'Training', '', @MaxRows, 21, 1 

CREATE PROCEDURE [dbo].pts_Question_Search ( 
      @SearchText nvarchar (200),
      @Bookmark nvarchar (14),
      @MaxRows tinyint OUTPUT,
      @CompanyID int,
      @Secure int
      )
AS

SET            NOCOUNT ON

SET            @MaxRows = 20

IF @Bookmark = '' 
	SET @Bookmark = '9999'

SELECT TOP 21
	dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(qu.QuestionID, 10) 'BookMark' ,
	qu.QuestionID,
	qu.QuestionDate,
	qu.Question,
	qu.Answer
FROM Question AS qu
INNER JOIN CONTAINSTABLE(Question,*, @SearchText, 1000 ) AS K ON qu.QuestionID = K.[KEY]
WHERE dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(qu.QuestionID, 10) <= @Bookmark
AND qu.CompanyID = @CompanyID
AND qu.Secure <= @Secure
AND qu.Status = 2
ORDER BY 'Bookmark' desc 

GO