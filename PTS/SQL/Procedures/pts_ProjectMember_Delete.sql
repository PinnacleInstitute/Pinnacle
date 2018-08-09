EXEC [dbo].pts_CheckProc 'pts_ProjectMember_Delete'
 GO

CREATE PROCEDURE [dbo].pts_ProjectMember_Delete ( 
   @ProjectMemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pjm
FROM ProjectMember AS pjm
WHERE pjm.ProjectMemberID = @ProjectMemberID

GO