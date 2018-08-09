EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_FindSalesCampaignName'
 GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_FindSalesCampaignName ( 
   @SearchText nvarchar (40),
   @Bookmark nvarchar (50),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(slc.SalesCampaignName, '') + dbo.wtfn_FormatNumber(slc.SalesCampaignID, 10) 'BookMark' ,
            slc.SalesCampaignID 'SalesCampaignID' ,
            slc.CompanyID 'CompanyID' ,
            slc.GroupID 'GroupID' ,
            slc.SalesCampaignName 'SalesCampaignName' ,
            slc.Seq 'Seq' ,
            slc.IsCopyURL 'IsCopyURL' ,
            slc.CopyURL 'CopyURL' ,
            slc.Result 'Result'
FROM SalesCampaign AS slc (NOLOCK)
WHERE ISNULL(slc.SalesCampaignName, '') LIKE '%' + @SearchText + '%'
AND ISNULL(slc.SalesCampaignName, '') + dbo.wtfn_FormatNumber(slc.SalesCampaignID, 10) >= @BookMark
AND         (slc.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO