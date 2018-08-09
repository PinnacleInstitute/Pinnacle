EXEC [dbo].pts_CheckProc 'pts_NewsLetter_FindNewsLetterName'
 GO

CREATE PROCEDURE [dbo].pts_NewsLetter_FindNewsLetterName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(nl.NewsLetterName, '') + dbo.wtfn_FormatNumber(nl.NewsLetterID, 10) 'BookMark' ,
            nl.NewsLetterID 'NewsLetterID' ,
            nl.CompanyID 'CompanyID' ,
            nl.MemberID 'MemberID' ,
            co.CompanyName 'CompanyName' ,
            me.NameLast 'NameLast' ,
            me.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) 'MemberName' ,
            nl.NewsLetterName 'NewsLetterName' ,
            nl.Status 'Status' ,
            nl.Description 'Description' ,
            nl.MemberCnt 'MemberCnt' ,
            nl.ProspectCnt 'ProspectCnt' ,
            nl.IsAttached 'IsAttached' ,
            nl.IsFeatured 'IsFeatured'
FROM NewsLetter AS nl (NOLOCK)
LEFT OUTER JOIN Company AS co (NOLOCK) ON (nl.CompanyID = co.CompanyID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (nl.MemberID = me.MemberID)
WHERE ISNULL(nl.NewsLetterName, '') LIKE '%' + @SearchText + '%'
AND ISNULL(nl.NewsLetterName, '') + dbo.wtfn_FormatNumber(nl.NewsLetterID, 10) >= @BookMark
AND         (nl.CompanyID = @CompanyID)
AND         (nl.Status = 2)
ORDER BY 'Bookmark'

GO