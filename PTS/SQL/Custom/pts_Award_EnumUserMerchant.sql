EXEC [dbo].pts_CheckProc 'pts_Award_EnumUserMerchant'
GO

EXEC pts_Award_EnumUserMerchant 1, 1, 1

CREATE PROCEDURE [dbo].pts_Award_EnumUserMerchant
   @MerchantID int ,
   @AwardType int ,
   @UserID int
AS

SET NOCOUNT ON
DECLARE @TimeZone int, @ListDate datetime
SELECT @TimeZone = TimeZone FROM Merchant WHERE MerchantID = @MerchantID
SET @ListDate = GETDATE()
--Adjust date-time for timezone
IF @TimeZone <> -6 SET @ListDate = DATEADD(HOUR, @TimeZone - -6, @ListDate)

SELECT awa.AwardID AS 'ID', 
       CAST(awa.Amount AS VARCHAR(10)) + CASE AwardType WHEN 1 THEN '%  ' ELSE '  ' END + awa.Description AS 'Name'
FROM Award AS awa (NOLOCK)
WHERE (awa.MerchantID = @MerchantID)
 AND (awa.AwardType = @AwardType)
 AND (awa.Status = 1)
 AND ( (StartDate = 0 OR StartDate <= @ListDate) AND (EndDate = 0 OR EndDate <= @ListDate) )

ORDER BY   awa.Seq

GO
