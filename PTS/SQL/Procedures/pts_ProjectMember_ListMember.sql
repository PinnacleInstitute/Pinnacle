EXEC [dbo].pts_CheckProc 'pts_ProjectMember_ListMember'
GO

CREATE PROCEDURE [dbo].pts_ProjectMember_ListMember
   @ProjectID int
AS

SET NOCOUNT ON

SELECT      pjm.ProjectMemberID, 
         pjm.MemberID, 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
         pjm.Status
FROM ProjectMember AS pjm (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pjm.MemberID = me.MemberID)
WHERE (pjm.ProjectID = @ProjectID)

ORDER BY   'MemberName'

GO