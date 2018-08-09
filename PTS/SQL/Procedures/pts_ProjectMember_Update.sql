EXEC [dbo].pts_CheckProc 'pts_ProjectMember_Update'
 GO

CREATE PROCEDURE [dbo].pts_ProjectMember_Update ( 
   @ProjectMemberID int,
   @ProjectID int,
   @MemberID int,
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pjm
SET pjm.ProjectID = @ProjectID ,
   pjm.MemberID = @MemberID ,
   pjm.Status = @Status
FROM ProjectMember AS pjm
WHERE pjm.ProjectMemberID = @ProjectMemberID

GO