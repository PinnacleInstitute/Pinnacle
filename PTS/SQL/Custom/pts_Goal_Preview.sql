EXEC [dbo].pts_CheckProc 'pts_Goal_Preview'
GO

CREATE PROCEDURE [dbo].pts_Goal_Preview
   @GoalID int 

AS
Select A.GoalID, A.ParentID, A.GoalName, A.Status, A.CommitDate, A.CompleteDate, A.Variance, A.Qty, A.ActQty, A.Description From Goal As A
Where A.ParentID = @GoalID
Union All
Select B.GoalID, B.ParentID, B.GoalName, B.Status, B.CommitDate, B.CompleteDate, B.Variance, B.Qty, B.ActQty, B.Description From Goal As A
Join Goal As B On A.GoalID = B.ParentID
Where A.ParentID = @GoalID
Union All
Select C.GoalID, C.ParentID, C.GoalName, C.Status, C.CommitDate, C.CompleteDate, C.Variance, C.Qty, C.ActQty, C.Description From Goal As A
Join Goal As B On A.GoalID = B.ParentID
Join Goal As C On B.GoalID = C.ParentID
Where A.ParentID = @GoalID
Union All
Select D.GoalID, D.ParentID, D.GoalName, D.Status, D.CommitDate, D.CompleteDate, D.Variance, D.Qty, D.ActQty, D.Description From Goal As A
Join Goal As B On A.GoalID = B.ParentID
Join Goal As C On B.GoalID = C.ParentID
Join Goal As D On C.GoalID = D.ParentID
Where A.ParentID = @GoalID
Order By GoalName

GO