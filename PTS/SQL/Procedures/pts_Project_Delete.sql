EXEC [dbo].pts_CheckProc 'pts_Project_Delete'
GO

CREATE PROCEDURE [dbo].pts_Project_Delete
   @ProjectID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   75 ,
   @ProjectID

EXEC pts_ProjectMember_DeleteMembers
   @ProjectID

EXEC pts_Task_DeleteTasks
   @ProjectID ,
   0

EXEC pts_Project_DeleteProjects
   @ProjectID

DELETE pj
FROM Project AS pj
WHERE (pj.ProjectID = @ProjectID)


GO