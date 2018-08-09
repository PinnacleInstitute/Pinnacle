EXEC [dbo].pts_CheckProc 'pts_Org_ListTree'
GO

CREATE PROCEDURE [dbo].pts_Org_ListTree
   @CompanyID int ,
   @UserID int
AS

SET         NOCOUNT ON

SELECT   org.OrgID, 
         org.ParentID, 
         org.CompanyID, 
         org.OrgName,
			org.CourseCount,
			org.MemberCount,
			org.IsPublic
FROM     Org AS org (NOLOCK)
WHERE    org.CompanyID = @CompanyID
ORDER BY org.OrgName

GO
