EXEC [dbo].pts_CheckProc 'pts_ProjectMember_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_ProjectMember_Fetch ( 
   @ProjectMemberID int,
   @ProjectID int OUTPUT,
   @MemberID int OUTPUT,
   @ProjectName nvarchar (60) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (61) OUTPUT,
   @Status int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ProjectID = pjm.ProjectID ,
   @MemberID = pjm.MemberID ,
   @ProjectName = pr.ProjectName ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) ,
   @Status = pjm.Status
FROM ProjectMember AS pjm (NOLOCK)
LEFT OUTER JOIN Project AS pr (NOLOCK) ON (pjm.ProjectID = pr.ProjectID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pjm.MemberID = me.MemberID)
WHERE pjm.ProjectMemberID = @ProjectMemberID

GO