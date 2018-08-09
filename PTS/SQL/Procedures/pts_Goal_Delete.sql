EXEC [dbo].pts_CheckProc 'pts_Goal_Delete'
GO

CREATE PROCEDURE [dbo].pts_Goal_Delete
   @GoalID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   70 ,
   @GoalID

EXEC pts_Goal_DeleteGoals
   @GoalID

DELETE go
FROM Goal AS go
WHERE (go.GoalID = @GoalID)


GO