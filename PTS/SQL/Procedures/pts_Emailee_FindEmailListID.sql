EXEC [dbo].pts_CheckProc 'pts_Emailee_FindEmailListID'
 GO

CREATE PROCEDURE [dbo].pts_Emailee_FindEmailListID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), eme.EmailListID), '') + dbo.wtfn_FormatNumber(eme.EmaileeID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), eme.EmailListID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), eme.EmailListID), '') + dbo.wtfn_FormatNumber(eme.EmaileeID, 10) >= @BookMark
AND         (eme.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO