EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ListPromotion'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ListPromotion
   @PromotionID int
AS

SET NOCOUNT ON

SELECT      so.SalesOrderID, 
         so.OrderDate, 
         me.NameFirst AS 'NameFirst', 
         me.NameLast AS 'NameLast', 
         so.Amount, 
         so.Total
FROM SalesOrder AS so (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (so.MemberID = me.MemberID)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (so.ProspectID = pr.ProspectID)
WHERE (so.PromotionID = @PromotionID)
 AND (so.Status >= 1)
 AND (so.Status <= 3)

ORDER BY   so.OrderDate

GO