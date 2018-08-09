EXEC [dbo].pts_CheckProc 'pts_Resource_ListUsing'
GO
--EXEC pts_Resource_ListUsing 6528

CREATE PROCEDURE [dbo].pts_Resource_ListUsing
   @MemberID int
AS

SET NOCOUNT ON
SELECT rs.ResourceID, rs.ResourceType, rs.ShareID, me.CompanyName 'ShareName', CASE WHEN (
	SELECT COUNT(*) FROM Resource 
	WHERE MemberID = rs.ShareID AND Share = 1 AND (ResourceType = rs.ResourceType OR ResourceType = 0) AND IsExclude = 0
	AND ( ShareID = 0 OR ShareID = @MemberID )
) = 0 THEN 1 ELSE 0 END AS 'IsExclude'
FROM Resource AS rs (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (rs.ShareID = me.MemberID)
WHERE rs.MemberID = @MemberID AND rs.Share = 0

GO
