EXEC [dbo].pts_CheckProc 'pts_Resource_ListSharing'
GO

CREATE PROCEDURE [dbo].pts_Resource_ListSharing
   @MemberID int
AS

SET NOCOUNT ON

SELECT      rs.ResourceID, 
         rs.ResourceType, 
         rs.ShareID, 
         me.CompanyName AS 'ShareName', 
         rs.IsExclude
FROM Resource AS rs (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (rs.ShareID = me.MemberID)
WHERE (rs.MemberID = @MemberID)
 AND (rs.Share = 1)

ORDER BY   rs.ResourceType

GO