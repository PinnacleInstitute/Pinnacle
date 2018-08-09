EXEC [dbo].pts_CheckProc 'pts_Task_ComputeTotalCost'
GO

CREATE PROCEDURE [dbo].pts_Task_ComputeTotalCost
   @TaskID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @ProjectID int, @ParentID int, @Total money, @TotalHrs money

-- Get the total costs of all child tasks for the specified task
SELECT @Total = ISNULL(SUM(TotCost),0), @TotalHrs = ISNULL(SUM(TotHrs),0) FROM Task WHERE ParentID = @TaskID
-- Save the total cost for the specified task
UPDATE Task 
SET TotCost = @Total + Cost, 
    VarCost = CASE EstCost WHEN 0 THEN 0 ELSE (@Total + Cost) - EstCost END,
    TotHrs = @TotalHrs + Hrs
WHERE TaskID = @TaskID
-- Get the specified Task's Parent and project
SELECT @ParentID = ParentID, @ProjectID = ProjectID FROM Task WHERE TaskID = @TaskID

-- Process all task's up the task chain
WHILE @ParentID > 0
BEGIN
-- 	Get the total costs of all child tasks
	SELECT @Total = ISNULL(SUM(TotCost),0), @TotalHrs = ISNULL(SUM(TotHrs),0) FROM Task WHERE ParentID = @ParentID
--	Save the total cost for the parent task
	UPDATE Task 
	SET TotCost = @Total + Cost, 
	VarCost = CASE EstCost WHEN 0 THEN 0 ELSE (@Total + Cost) - EstCost END, 
	TotHrs = @TotalHrs + Hrs
	WHERE TaskID = @ParentID
--	Get the next parent up the task chain
	SELECT @ParentID = ParentID FROM Task WHERE TaskID = @ParentID
END
-- Get the total costs for all top level task to the project
SELECT @Total = ISNULL(SUM(TotCost),0), @TotalHrs = ISNULL(SUM(TotHrs),0) FROM Task WHERE ProjectID = @ProjectID AND ParentID = 0
-- Get the total costs for all sub-projects for the project
SELECT @Total = @Total + ISNULL(SUM(TotCost),0), @TotalHrs = @TotalHrs + ISNULL(SUM(TotHrs),0) FROM Project WHERE ParentID = @ProjectID
-- Save the total cost for the specified project 
UPDATE Project 
SET TotCost = @Total + Cost, 
    VarCost = CASE EstCost WHEN 0 THEN 0 ELSE (@Total + Cost) - EstCost END, 
    TotHrs = @TotalHrs + Hrs
WHERE ProjectID = @ProjectID
-- Get the next parent up the project chain
SELECT @ParentID = ParentID FROM Project WHERE ProjectID = @ProjectID

-- Process all project's up the project chain
WHILE @ParentID > 0
BEGIN
-- 	Get the total costs of all child projects
	SELECT @Total = ISNULL(SUM(TotCost),0), @TotalHrs = ISNULL(SUM(TotHrs),0) FROM Project WHERE ParentID = @ParentID
-- 	Save the total cost for the project 
	UPDATE Project 
	SET TotCost = @Total + Cost, 
	VarCost = CASE EstCost WHEN 0 THEN 0 ELSE (@Total + Cost) - EstCost END, 
	TotHrs = @TotalHrs + Hrs
	WHERE ProjectID = @ParentID
--	Get the next parent up the project chain
	SELECT @ParentID = ParentID FROM Project WHERE ProjectID = @ParentID
END

GO
