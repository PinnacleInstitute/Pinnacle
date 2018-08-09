EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_EnumUserCompanyResult'
GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_EnumUserCompanyResult
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      MIN(slc.SalesCampaignID) AS 'ID', 
         slc.Result AS 'Name'
FROM SalesCampaign AS slc (NOLOCK)
WHERE (slc.CompanyID = @CompanyID)
 AND (slc.Seq >= 0)
 AND (slc.Result <> '')
GROUP BY slc.Result
ORDER BY slc.Result

GO