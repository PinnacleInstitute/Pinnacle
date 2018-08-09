EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_EnumUserCompany
   @CompanyID int ,
   @GroupID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      slc.SalesCampaignID AS 'ID', 
         slc.SalesCampaignName AS 'Name'
FROM SalesCampaign AS slc (NOLOCK)
WHERE (slc.CompanyID = @CompanyID)
 AND (slc.Seq >= 0)
 AND ((slc.GroupID = 0)
 OR (slc.GroupID = @GroupID))

ORDER BY   slc.Seq

GO