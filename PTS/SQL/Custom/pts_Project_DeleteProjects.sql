EXEC [dbo].pts_CheckProc 'pts_Project_DeleteProjects'
GO
CREATE PROCEDURE [dbo].pts_Project_DeleteProjects
   @ProjectID int
AS

SET NOCOUNT ON

DECLARE @ID int

DECLARE Project_cursor CURSOR LOCAL STATIC FOR 
SELECT ProjectID FROM Project WHERE ParentID = @ProjectID

OPEN Project_cursor
FETCH NEXT FROM Project_cursor INTO @ID
WHILE @@FETCH_STATUS = 0
BEGIN
-- 	Delete all Tasks for this project
	EXEC pts_Task_DeleteTasks @ID, 0 

-- 	Delete all Sub-projects for this project
	EXEC pts_Project_DeleteProjects @ID

--	Delete Shortcuts
	EXEC pts_Shortcut_DeleteItem 75, @ID

--	Delete Attachments
	EXEC pts_Attachment_DeleteParent 75, @ID, 1

--	Delete Notes
	EXEC pts_Note_DeleteOwner 75, @ID, 1

--	Delete Project
	DELETE Project Where ProjectID = @ID

--PRINT 'Project: ' + CAST(@ID AS varchar(10))

	FETCH NEXT FROM Project_cursor INTO @ID
END
CLOSE Project_cursor
DEALLOCATE Project_cursor

GO
