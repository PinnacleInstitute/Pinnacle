EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ListParty'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ListParty
   @PartyID int
AS

SET NOCOUNT ON

SELECT      so.SalesOrderID, 
         so.OrderDate, 
         so.Total, 
         so.BV, 
         so.Status, 
         so.Notes, 
         so.IsRecur, 
         so.ProspectID, 
         LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) AS 'MemberName'
FROM SalesOrder AS so (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (so.MemberID = me.MemberID)
WHERE (so.PartyID = @PartyID)
 AND (so.Status >= 1)
 AND (so.Status <= 3)

ORDER BY   so.OrderDate DESC

GO