EXEC [dbo].pts_CheckProc 'pts_SalesMember_List'
GO

CREATE PROCEDURE [dbo].pts_SalesMember_List
   @SalesAreaID int
AS

SET NOCOUNT ON

SELECT      slm.SalesMemberID, 
         slm.SalesAreaID, 
         slm.MemberID, 
         sla.SalesAreaName AS 'SalesAreaName', 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
         slm.Status, 
         slm.StatusDate, 
         slm.FTE, 
         slm.Assignment
FROM SalesMember AS slm (NOLOCK)
LEFT OUTER JOIN SalesArea AS sla (NOLOCK) ON (slm.SalesAreaID = sla.SalesAreaID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (slm.MemberID = me.MemberID)
WHERE (slm.SalesAreaID = @SalesAreaID)

ORDER BY   me.NameLast , me.NameFirst

GO