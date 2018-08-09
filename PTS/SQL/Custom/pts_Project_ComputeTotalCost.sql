EXEC [dbo].pts_CheckProc 'pts_Project_ComputeTotalCost'
GO

CREATE PROCEDURE [dbo].pts_Project_ComputeTotalCost
   @ProjectID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @ParentID int, @Total money, @TotalHrs money

-- Get the total costs for all top level tasks to the project
SELECT @Total = ISNULL(SUM(TotCost),0), @TotalHrs = ISNULL(SUM(TotHrs),0) FROM Task WHERE ProjectID = @ProjectID AND ParentID = 0
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
