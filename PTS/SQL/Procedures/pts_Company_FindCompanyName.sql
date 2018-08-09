EXEC [dbo].pts_CheckProc 'pts_Company_FindCompanyName'
 GO

CREATE PROCEDURE [dbo].pts_Company_FindCompanyName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(com.CompanyName, '') + dbo.wtfn_FormatNumber(com.CompanyID, 10) 'BookMark' ,
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
WHERE ISNULL(com.CompanyName, '') LIKE @SearchText + '%'
AND ISNULL(com.CompanyName, '') + dbo.wtfn_FormatNumber(com.CompanyID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO