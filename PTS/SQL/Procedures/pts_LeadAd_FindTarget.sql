EXEC [dbo].pts_CheckProc 'pts_LeadAd_FindTarget'
 GO

CREATE PROCEDURE [dbo].pts_LeadAd_FindTarget ( 
   @SearchText nvarchar (30),
   @Bookmark nvarchar (40),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(la.Target, '') + dbo.wtfn_FormatNumber(la.LeadAdID, 10) 'BookMark' ,
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
WHERE ISNULL(la.Target, '') LIKE @SearchText + '%'
AND ISNULL(la.Target, '') + dbo.wtfn_FormatNumber(la.LeadAdID, 10) >= @BookMark
AND         (la.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO