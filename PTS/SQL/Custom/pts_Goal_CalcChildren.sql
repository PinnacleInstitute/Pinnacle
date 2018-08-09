EXEC [dbo].pts_CheckProc 'pts_Goal_CalcChildren'
GO

CREATE PROCEDURE [dbo].pts_Goal_CalcChildren
   @GoalID int ,
   @UserID int
AS

SET NOCOUNT ON

UPDATE Goal Set Children = (SELECT COUNT(GoalID) FROM Goal WHERE ParentID = @GoalID)
WHERE GoalID = @GoalID

GO