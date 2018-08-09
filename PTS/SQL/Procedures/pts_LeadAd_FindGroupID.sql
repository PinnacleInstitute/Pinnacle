EXEC [dbo].pts_CheckProc 'pts_LeadAd_FindGroupID'
 GO

CREATE PROCEDURE [dbo].pts_LeadAd_FindGroupID ( 
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
            ISNULL(CONVERT(nvarchar(10), la.GroupID), '') + dbo.wtfn_FormatNumber(la.LeadAdID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), la.GroupID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), la.GroupID), '') + dbo.wtfn_FormatNumber(la.LeadAdID, 10) >= @BookMark
AND         (la.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO