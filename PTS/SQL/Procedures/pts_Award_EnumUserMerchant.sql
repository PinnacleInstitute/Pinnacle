EXEC [dbo].pts_CheckProc 'pts_Award_EnumUserMerchant'
GO

CREATE PROCEDURE [dbo].pts_Award_EnumUserMerchant
   @MerchantID int ,
   @AwardType int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      awa.AwardID AS 'ID', 
         CAST(awa.Amount AS VARCHAR(10)) + CASE AwardType WHEN 1 THEN '%  ' ELSE '  ' END + awa.Description AS 'Name'
FROM Award AS awa (NOLOCK)
WHERE (awa.MerchantID = @MerchantID)
 AND (awa.AwardType = @AwardType)
 AND (awa.Status = 1)

ORDER BY   awa.Seq

GO