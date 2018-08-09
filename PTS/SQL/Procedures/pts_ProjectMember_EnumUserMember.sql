EXEC [dbo].pts_CheckProc 'pts_ProjectMember_EnumUserMember'
GO

CREATE PROCEDURE [dbo].pts_ProjectMember_EnumUserMember
   @ProjectID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      pjm.MemberID AS 'ID', 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'Name'
FROM ProjectMember AS pjm (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pjm.MemberID = me.MemberID)
WHERE (pjm.ProjectID = @ProjectID)

ORDER BY   'MemberName'

GO