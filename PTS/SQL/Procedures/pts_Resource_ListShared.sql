EXEC [dbo].pts_CheckProc 'pts_Resource_ListShared'
GO

CREATE PROCEDURE [dbo].pts_Resource_ListShared
   @CompanyID int ,
   @MemberID int ,
   @ResourceType int
AS

SET NOCOUNT ON

SELECT      rs.ResourceID, 
         rs.MemberID, 
         me.CompanyName AS 'MemberName'
FROM Resource AS rs (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (rs.MemberID = me.MemberID)
WHERE (me.CompanyID = @CompanyID)
 AND (rs.MemberID <> @MemberID)
 AND (rs.Share = 1)
 AND ((rs.ResourceType = 0)
 OR (rs.ResourceType = @ResourceType))
 AND ((rs.ShareID = 0)
 OR ((rs.ShareID = @MemberID)
 AND (rs.IsExclude = 0)))

ORDER BY   'MemberName'

GO