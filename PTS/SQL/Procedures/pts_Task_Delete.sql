EXEC [dbo].pts_CheckProc 'pts_Task_Delete'
GO

CREATE PROCEDURE [dbo].pts_Task_Delete
   @TaskID int ,
   @ProjectID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   74 ,
   @TaskID

EXEC pts_Task_DeleteTasks
   @ProjectID ,
   @TaskID

DELETE ta
FROM Task AS ta
WHERE (ta.TaskID = @TaskID)


GO