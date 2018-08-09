EXEC [dbo].pts_CheckProc 'pts_LeadAd_FindLeadAdName'
 GO

CREATE PROCEDURE [dbo].pts_LeadAd_FindLeadAdName ( 
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
            ISNULL(la.LeadAdName, '') + dbo.wtfn_FormatNumber(la.LeadAdID, 10) 'BookMark' ,
            la.LeadAdID 'LeadAdID' ,
            la.CompanyID 'CompanyID' ,
            la.GroupID 'GroupID' ,
            la.LeadAdName 'LeadAdName' ,
            la.Status 'Status' ,
            la.Target 'Target' ,
            la.Link 'Link' ,
            la.Seq 'Seq' ,
            la.Image 'Image'
FROM LeadAd AS la (NOLOCK)
WHERE ISNULL(la.LeadAdName, '') LIKE '%' + @SearchText + '%'
AND ISNULL(la.LeadAdName, '') + dbo.wtfn_FormatNumber(la.LeadAdID, 10) >= @BookMark
AND         (la.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO