EXEC [dbo].pts_CheckProc 'pts_Company_FindCompanyType'
 GO

CREATE PROCEDURE [dbo].pts_Company_FindCompanyType ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), com.CompanyType), '') + dbo.wtfn_FormatNumber(com.CompanyID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), com.CompanyType), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), com.CompanyType), '') + dbo.wtfn_FormatNumber(com.CompanyID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO