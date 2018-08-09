EXEC [dbo].pts_CheckProc 'pts_Resource_ListUsed'
GO

CREATE PROCEDURE [dbo].pts_Resource_ListUsed
   @MemberID int
AS

SET NOCOUNT ON

SELECT      rs.ResourceID, 
         rs.ResourceType, 
         rs.MemberID, 
         me.CompanyName AS 'MemberName'
FROM Resource AS rs (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (rs.MemberID = me.MemberID)
WHERE (rs.ShareID = @MemberID)
 AND (rs.Share = 0)

ORDER BY   rs.ResourceType , 'MemberName'

GO