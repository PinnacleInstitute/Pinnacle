EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_FindGroupID'
 GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_FindGroupID ( 
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
            ISNULL(CONVERT(nvarchar(10), slc.GroupID), '') + dbo.wtfn_FormatNumber(slc.SalesCampaignID, 10) 'BookMark' ,
            slc.SalesCampaignID 'SalesCampaignID' ,
            slc.CompanyID 'CompanyID' ,
            slc.GroupID 'GroupID' ,
            slc.SalesCampaignName 'SalesCampaignName' ,
            slc.Seq 'Seq' ,
            slc.IsCopyURL 'IsCopyURL' ,
            slc.CopyURL 'CopyURL' ,
            slc.Result 'Result'
FROM SalesCampaign AS slc (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), slc.GroupID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), slc.GroupID), '') + dbo.wtfn_FormatNumber(slc.SalesCampaignID, 10) >= @BookMark
AND         (slc.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO