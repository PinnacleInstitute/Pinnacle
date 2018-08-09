EXEC [dbo].pts_CheckProc 'pts_ProjectMember_DeleteMembers'
GO
CREATE PROCEDURE [dbo].pts_ProjectMember_DeleteMembers
   @ProjectID int
AS

SET NOCOUNT ON

DELETE ProjectMember WHERE ProjectID = @ProjectID

GO
