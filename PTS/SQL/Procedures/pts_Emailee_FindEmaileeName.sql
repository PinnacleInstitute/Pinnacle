EXEC [dbo].pts_CheckProc 'pts_Emailee_FindEmaileeName'
 GO

CREATE PROCEDURE [dbo].pts_Emailee_FindEmaileeName ( 
   @SearchText nvarchar (62),
   @Bookmark nvarchar (72),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(LTRIM(RTRIM(eme.LastName)) +  ', '  + LTRIM(RTRIM(eme.FirstName)), '') + dbo.wtfn_FormatNumber(eme.EmaileeID, 10) 'BookMark' ,
            eme.EmaileeID 'EmaileeID' ,
            eme.CompanyID 'CompanyID' ,
            eme.EmailListID 'EmailListID' ,
            eme.Email 'Email' ,
            eme.FirstName 'FirstName' ,
            eme.LastName 'LastName' ,
            LTRIM(RTRIM(eme.LastName)) +  ', '  + LTRIM(RTRIM(eme.FirstName)) 'EmaileeName' ,
            eme.Data1 'Data1' ,
            eme.Data2 'Data2' ,
            eme.Data3 'Data3' ,
            eme.Data4 'Data4' ,
            eme.Data5 'Data5' ,
            eme.Status 'Status'
FROM Emailee AS eme (NOLOCK)
WHERE ISNULL(LTRIM(RTRIM(eme.LastName)) +  ', '  + LTRIM(RTRIM(eme.FirstName)), '') LIKE '%' + @SearchText + '%'
AND ISNULL(LTRIM(RTRIM(eme.LastName)) +  ', '  + LTRIM(RTRIM(eme.FirstName)), '') + dbo.wtfn_FormatNumber(eme.EmaileeID, 10) >= @BookMark
AND         (eme.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO