EXEC [dbo].pts_CheckProc 'pts_Goal_Copy'
GO

--DECLARE @NewGoalID int 
--EXEC pts_Goal_CopyGoal 2, 84, 0, '', 1, 0, @NewGoalID OUTPUT
--PRINT CAST(@NewGoalID AS VARCHAR(10))

CREATE PROCEDURE [dbo].pts_Goal_Copy
   @GoalID int ,
   @MemberID int ,
   @ProspectID int ,
   @GoalName nvarchar (60),
   @UserID int ,
   @NewGoalID int OUTPUT
AS

DECLARE @CreateDate datetime
SELECT @CreateDate = CreateDate FROM Goal WHERE GoalID = @GoalID

EXEC pts_Goal_CopyGoal @GoalID, @MemberID, @ProspectID, @GoalName, @UserID, 0, @CreateDate, @NewGoalID OUTPUT

GO