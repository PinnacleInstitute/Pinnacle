EXEC [dbo].pts_CheckProc 'pts_Task_DeleteTasks'
GO
CREATE PROCEDURE [dbo].pts_Task_DeleteTasks
   @ProjectID int ,
   @ParentID int
AS

SET NOCOUNT ON

DECLARE @ID int

DECLARE Task_cursor CURSOR LOCAL STATIC FOR 
SELECT TaskID FROM Task WHERE ProjectID = @ProjectID AND ParentID = @ParentID

OPEN Task_cursor
FETCH NEXT FROM Task_cursor INTO @ID
WHILE @@FETCH_STATUS = 0
BEGIN
-- 	Delete all Sub-Tasks for this Task
	EXEC pts_Task_DeleteTasks @ProjectID, @ID

--	Delete Shortcuts
	EXEC pts_Shortcut_DeleteItem 74, @ID

--	Delete Attachments
	EXEC pts_Attachment_DeleteParent 74, @ID, 1

--	Delete Notes
	EXEC pts_Note_DeleteOwner 74, @ID, 1

--	Delete Task
	DELETE Task Where TaskID = @ID

--PRINT 'Task: ' + CAST(@ID AS varchar(10))

	FETCH NEXT FROM Task_cursor INTO @ID
END
CLOSE Task_cursor
DEALLOCATE Task_cursor

GO
