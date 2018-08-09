EXEC [dbo].pts_CheckProc 'pts_Goal_ListParent'
GO

CREATE PROCEDURE [dbo].pts_Goal_ListParent
   @ParentID int
AS

SET NOCOUNT ON

SELECT      go.GoalID, 
         go.MemberID, 
         go.ParentID, 
         go.AssignID, 
         go.GoalName, 
         go.Description, 
         go.Priority, 
         go.Status, 
         go.CommitDate, 
         go.CompleteDate, 
         go.RemindDate, 
         go.Variance, 
         go.Children, 
         go.Qty, 
         go.ActQty
FROM Goal AS go (NOLOCK)
WHERE (go.ParentID = @ParentID)

ORDER BY   go.GoalName

GO