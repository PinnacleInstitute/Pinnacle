EXEC [dbo].pts_CheckProc 'pts_DripCampaign_EnumDripList'
GO

CREATE PROCEDURE [dbo].pts_DripCampaign_EnumDripList
   @CompanyID int ,
   @GroupID int ,
   @GroupID1 int ,
   @GroupID2 int ,
   @GroupID3 int ,
   @Target int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      dec.DripCampaignID AS 'ID', 
         dec.DripCampaignName AS 'Name'
FROM DripCampaign AS dec (NOLOCK)
WHERE (dec.CompanyID = @CompanyID)
 AND (dec.Status = 2)
 AND (dec.Target = @Target)
 AND ((dec.GroupID = 0)
 OR (dec.GroupID = @GroupID)
 OR ((dec.GroupID = @GroupID1)
 AND (dec.IsShare <> 0))
 OR ((dec.GroupID = @GroupID2)
 AND (dec.IsShare <> 0))
 OR ((dec.GroupID = @GroupID3)
 AND (dec.IsShare <> 0)))

ORDER BY   dec.DripCampaignName

GO