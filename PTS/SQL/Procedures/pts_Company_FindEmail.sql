EXEC [dbo].pts_CheckProc 'pts_Company_FindEmail'
 GO

CREATE PROCEDURE [dbo].pts_Company_FindEmail ( 
   @SearchText nvarchar (80),
   @Bookmark nvarchar (90),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(com.Email, '') + dbo.wtfn_FormatNumber(com.CompanyID, 10) 'BookMark' ,
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
WHERE ISNULL(com.Email, '') LIKE @SearchText + '%'
AND ISNULL(com.Email, '') + dbo.wtfn_FormatNumber(com.CompanyID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO