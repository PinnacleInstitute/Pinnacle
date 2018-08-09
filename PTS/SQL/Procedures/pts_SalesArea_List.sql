EXEC [dbo].pts_CheckProc 'pts_SalesArea_List'
GO

CREATE PROCEDURE [dbo].pts_SalesArea_List
   @ParentID int
AS

SET NOCOUNT ON

SELECT      sla.SalesAreaID, 
         sla.ParentID, 
         sla.MemberID, 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
         sla.SalesAreaName, 
         sla.Status, 
         sla.StatusDate, 
         sla.Level, 
         sla.Density, 
         sla.Population, 
         sla.FTE
FROM SalesArea AS sla (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (sla.MemberID = me.MemberID)
WHERE (sla.ParentID = @ParentID)

ORDER BY   sla.SalesAreaName

GO