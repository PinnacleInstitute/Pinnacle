EXEC [dbo].pts_CheckProc 'pts_Org_ListBranch'
GO

CREATE PROCEDURE [dbo].pts_Org_ListBranch
   @OrgID int ,
   @UserID int
AS

SET         NOCOUNT ON

DECLARE @Hierarchy varchar(100)

SELECT @Hierarchy = Hierarchy FROM Org WHERE OrgID = @OrgID

SELECT   org.OrgID, 
         org.ParentID, 
         org.CompanyID, 
         org.OrgName,
		   org.CourseCount,
			org.MemberCount,
			org.IsPublic
FROM     Org AS org (NOLOCK)
WHERE    Org.Hierarchy LIKE @Hierarchy + '%'

GO