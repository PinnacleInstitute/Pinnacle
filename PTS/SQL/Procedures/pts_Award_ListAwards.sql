EXEC [dbo].pts_CheckProc 'pts_Award_ListAwards'
GO

CREATE PROCEDURE [dbo].pts_Award_ListAwards
   @MerchantID int ,
   @AwardType int
AS

SET NOCOUNT ON

SELECT      awa.AwardID, 
         awa.AwardType, 
         awa.Seq, 
         awa.Amount, 
         awa.Status, 
         awa.Description, 
         awa.Cap
FROM Award AS awa (NOLOCK)
WHERE (awa.MerchantID = @MerchantID)
 AND (awa.AwardType = @AwardType)
 AND (awa.Status = 1)

ORDER BY   awa.Seq

GO