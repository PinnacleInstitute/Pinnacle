EXEC [dbo].pts_CheckProc 'pts_Award_ListAllAwards'
GO

CREATE PROCEDURE [dbo].pts_Award_ListAllAwards
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
         awa.Cap, 
         awa.Award, 
         awa.StartDate, 
         awa.EndDate
FROM Award AS awa (NOLOCK)
WHERE (awa.MerchantID = @MerchantID)
 AND (awa.AwardType = @AwardType)

ORDER BY   awa.Seq

GO