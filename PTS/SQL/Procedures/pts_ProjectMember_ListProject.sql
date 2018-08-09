EXEC [dbo].pts_CheckProc 'pts_ProjectMember_ListProject'
GO

CREATE PROCEDURE [dbo].pts_ProjectMember_ListProject
   @MemberID int
AS

SET NOCOUNT ON

SELECT      pjm.ProjectMemberID, 
         pr.ProjectName AS 'ProjectName', 
         pjm.Status
FROM ProjectMember AS pjm (NOLOCK)
LEFT OUTER JOIN Project AS pr (NOLOCK) ON (pjm.ProjectID = pr.ProjectID)
WHERE (pjm.MemberID = @MemberID)

ORDER BY   pr.ProjectName

GO