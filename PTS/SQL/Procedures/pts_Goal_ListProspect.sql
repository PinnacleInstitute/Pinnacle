EXEC [dbo].pts_CheckProc 'pts_Goal_ListProspect'
GO

CREATE PROCEDURE [dbo].pts_Goal_ListProspect
   @ProspectID int
AS

SET NOCOUNT ON

SELECT      go.GoalID, 
         go.MemberID, 
         go.ParentID, 
         go.ProspectID, 
         go.AssignID, 
         go.GoalName, 
         go.Description, 
         go.GoalType, 
         go.Priority, 
         go.Status, 
         go.CommitDate, 
         go.CompleteDate, 
         go.Variance, 
         go.Children, 
         go.Qty, 
         go.ActQty
FROM Goal AS go (NOLOCK)
WHERE (go.ProspectID = @ProspectID)
 AND (go.ParentID = 0)

ORDER BY   go.GoalName

GO