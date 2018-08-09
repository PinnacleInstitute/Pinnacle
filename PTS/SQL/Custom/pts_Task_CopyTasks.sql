EXEC [dbo].pts_CheckProc 'pts_Task_CopyTasks'
GO
CREATE PROCEDURE [dbo].pts_Task_CopyTasks
   @ProjectID int ,
   @ParentID int ,
   @NewProjectID int , 
   @NewParentID int , 
   @Exclude nvarchar (1000) ,
   @ProjectStartDate datetime ,
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

DECLARE @Now datetime, @NewTaskID int
DECLARE @ID int, @TaskName nvarchar (60), @Description nvarchar (1000),
   @Seq int, @IsMilestone bit, @EstStartDate datetime, @EstEndDate datetime

SET @Now = dbo.wtfn_DateOnly(GETDATE())

DECLARE Task_cursor CURSOR LOCAL STATIC FOR 
SELECT  TaskID, TaskName, [Description], Seq, IsMilestone, EstStartDate, EstEndDate
FROM Task WHERE ProjectID = @ProjectID AND ParentID = @ParentID
ORDER BY Seq

OPEN Task_cursor
FETCH NEXT FROM Task_cursor INTO @ID, @TaskName, @Description, @Seq, @IsMilestone, @EstStartDate, @EstEndDate
WHILE @@FETCH_STATUS = 0
BEGIN
	IF CHARINDEX('T' + CAST(@ID AS VARCHAR(10)) + '~', @Exclude) = 0
	BEGIN
-- 		Calculate new estimated start date
		IF @EstStartDate > 0
			SET @EstStartDate = DATEADD( day, DATEDIFF(day, @ProjectStartDate, @EstStartDate ), @Now )
-- 		Calculate new estimated end date
		IF @EstEndDate > 0
			SET @EstEndDate = DATEADD( day, DATEDIFF(day, @ProjectStartDate, @EstEndDate ), @Now )

-- 		TaskID, MemberID, ParentID, ProjectID, DependentID, TaskName, Description, Status, Seq, IsMilestone,
-- 		EstStartDate, ActStartDate, @VarStartDate, EstEndDate, ActEndDate, VarEndDate,
-- 		EstCost, TotCost, VarCost, Cost, Hrs, TotHrs, UserID 
		EXEC pts_Task_Add @NewTaskID OUTPUT, @MemberID, @NewParentID, @NewProjectID, 0, @TaskName, @Description, 0, @Seq, @IsMilestone,
   		@EstStartDate, 0, 0, @EstEndDate, 0, 0, 
		   0, 0, 0, 0, 0, 0, @UserID

--PRINT 'Task: ' + @TaskName + ' - ' + CAST(@ID AS varchar(10))

-- 		Add all Tasks for this task
		EXEC pts_Task_CopyTasks @ProjectID, @ID, @NewProjectID, @NewTaskID, @Exclude, @ProjectStartDate, @MemberID, @UserID 
	END
	FETCH NEXT FROM Task_cursor INTO @ID, @TaskName, @Description, @Seq, @IsMilestone, @EstStartDate, @EstEndDate
END
CLOSE Task_cursor
DEALLOCATE Task_cursor

GO
