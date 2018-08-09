EXEC [dbo].pts_CheckProc 'pts_Company_FindEnrollDate'
 GO

CREATE PROCEDURE [dbo].pts_Company_FindEnrollDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
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
            ISNULL(CONVERT(nvarchar(10), com.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(com.CompanyID, 10) 'BookMark' ,
            com.CompanyID 'CompanyID' ,
            com.CompanyName 'CompanyName' ,
            LTRIM(RTRIM(com.NameLast)) +  ', '  + LTRIM(RTRIM(com.NameFirst)) 'ContactName' ,
            com.Status 'Status' ,
            com.EnrollDate 'EnrollDate' ,
            com.CompanyType 'CompanyType' ,
            com.Email 'Email' ,
            com.Street 'Street' ,
            com.Unit 'Unit' ,
            com.City 'City' ,
            com.State 'State' ,
            com.Zip 'Zip' ,
            com.Country 'Country'
FROM Company AS com (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), com.EnrollDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), com.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(com.CompanyID, 10) <= @BookMark
ORDER BY 'Bookmark' DESC

GO