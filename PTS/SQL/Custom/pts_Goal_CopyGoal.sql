EXEC [dbo].pts_CheckProc 'pts_Goal_CopyGoal'
GO

CREATE PROCEDURE [dbo].pts_Goal_CopyGoal
   @GoalID int ,
   @MemberID int ,
   @ProspectID int ,
   @Name nvarchar (60),
   @UserID int ,
   @ParentID int ,
   @CreateDate datetime ,
   @NewGoalID int OUTPUT
AS

DECLARE @CommitDate datetime, @RemindDate datetime, @GoalName nvarchar(60), @Description nvarchar(2000) 
DECLARE @GoalType int, @Priority int, @Children int, @Qty int
DECLARE @ChildGoalID int, @NewChildGoalID int
DECLARE @Now datetime, @Days int, @RemindDays int

--print CAST(@goalid as varchar(10))

-- FETCH THE SPECIFIED EXISTING GOAL
SELECT @GoalName = GoalName, @Description = Description, @GoalType = GoalType, @Priority = Priority, 
       @CommitDate = CommitDate, @RemindDate = RemindDate, @Children = Children, @Qty = Qty
FROM Goal WHERE GoalID = @GoalID

IF LEN(@GoalName) <> 0
BEGIN
	IF LEN(@Name) <> 0 SET @GoalName = @Name

	SET @Now = dbo.wtfn_DateOnly(GETDATE())
	IF @CommitDate > 0 
	BEGIN
--		GET NUMBER OF DAYS BETWEEN CREATE DATE AND COMMIT DATE 
		SET @Days = DATEDIFF(DAY, @CreateDate, @CommitDate)
--		ADJUST COMMIT DATE, ADD NUMBER OF DAYS TO TODAY 
		SET @CommitDate = DATEADD(DAY, @Days, @Now)
	END
	IF @RemindDate > 0 
	BEGIN
		SET @RemindDays = DATEDIFF(DAY, @CreateDate, @RemindDate)
		SET @RemindDate = DATEADD(DAY, @RemindDays, @Now)
	END

--	ADD A COPY OF THE EXISTING GOAL
--	GoalID, MemberID, ParentID, AssignID, CompanyID, GoalName, Description,
--	GoalType, Priority, Status, CreateDate, CommitDate, CompleteDate, Variance, RemindDate, Template, Children, UserID
	EXEC pts_Goal_Add @NewGoalID OUTPUT, @MemberID, @ParentID, @UserID, 0, @ProspectID, @GoalName, @Description,
			  @GoalType, @Priority, 2, @Now, @CommitDate, 0, 0, @RemindDate, 0, @Children, @Qty, 0, @UserID

--print 'NEW: ' + CAST(@newgoalid as varchar(10))

--      COPY ALL REMINDER NOTES FOR THIS GOAL
	SET @Now = GETDATE()
	DECLARE @NoteID int, @NoteDate datetime, @Notes varchar (1000), @IsLocked bit, @IsFrozen bit
	DECLARE Note_cursor CURSOR LOCAL STATIC FOR 
	SELECT  Notes, NoteDate, IsLocked, IsFrozen FROM Note 
	WHERE OwnerType = 70 AND OwnerID = @GoalID AND IsReminder = 1
	OPEN Note_cursor
	FETCH NEXT FROM Note_cursor INTO @Notes, @NoteDate, @IsLocked, @IsFrozen 
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		GET NUMBER OF DAYS BETWEEN CREATE DATE AND NOTE DATE 
		SET @Days = DATEDIFF(DAY, @CreateDate, @NoteDate)
--		ADJUST NOTE DATE, ADD NUMBER OF DAYS TO TODAY 
		SET @NoteDate = DATEADD(DAY, @Days, @Now)

--		NoteID, OwnerType, OwnerID, AuthUserID, NoteDate, Notes, IsLocked, IsFrozen, IsReminder, UserID
		EXEC pts_Note_Add @NoteID OUTPUT, 70, @NewGoalID, @UserID, @NoteDate, @Notes, @IsLocked, @IsFrozen, 1, @UserID  
		FETCH NEXT FROM Note_cursor INTO @Notes, @NoteDate, @IsLocked, @IsFrozen 
	END
	CLOSE Note_cursor
	DEALLOCATE Note_cursor

--      COPY ALL SUB GOALS (RECURSIVE)
	DECLARE Goal_cursor CURSOR LOCAL STATIC FOR 
	SELECT  GoalID FROM Goal WHERE ParentID = @GoalID
	OPEN Goal_cursor
	FETCH NEXT FROM Goal_cursor INTO @ChildGoalID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC pts_Goal_CopyGoal @ChildGoalID, @MemberID, @ProspectID, '', @UserID, @NewGoalID, @CreateDate, @NewChildGoalID OUTPUT
		FETCH NEXT FROM Goal_cursor INTO @ChildGoalID
	END
	CLOSE Goal_cursor
	DEALLOCATE Goal_cursor
END

GO