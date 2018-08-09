EXEC [dbo].pts_CheckProc 'pts_Payment2_ListApprove'
GO

CREATE PROCEDURE [dbo].pts_Payment2_ListApprove
   @MerchantID int
AS

SET NOCOUNT ON

SELECT      pa2.Payment2ID, 
         LTRIM(RTRIM(con.NameFirst)) +  ' '  + LTRIM(RTRIM(con.NameLast)) AS 'ConsumerName', 
         sta.StaffName AS 'StaffName', 
         awd.Description AS 'AwardName', 
         pa2.PayDate, 
         pa2.PayType, 
         pa2.Status, 
         pa2.Total, 
         pa2.Amount, 
         pa2.Merchant, 
         pa2.Cashback, 
         pa2.Fee, 
         pa2.Ticket
FROM Payment2 AS pa2 (NOLOCK)
LEFT OUTER JOIN Consumer AS con (NOLOCK) ON (pa2.ConsumerID = con.ConsumerID)
LEFT OUTER JOIN Staff AS sta (NOLOCK) ON (pa2.StaffID = sta.StaffID)
LEFT OUTER JOIN Award AS awd (NOLOCK) ON (pa2.AwardID = awd.AwardID)
WHERE (pa2.MerchantID = @MerchantID)
 AND (pa2.PayType = 1)
 AND (pa2.Status = 1)

ORDER BY   pa2.PayDate DESC

GO