EXEC [dbo].pts_CheckProc 'pts_Goal_Goals'
GO

CREATE PROCEDURE [dbo].pts_Goal_Goals
   @GoalID int 

AS

Select A.GoalID, A.ParentID, A.GoalName, A.Description, A.Qty From Goal As A
Where A.ParentID = @GoalID
Union All
Select B.GoalID, B.ParentID, B.GoalName, B.Description, B.Qty From Goal As A
Join Goal As B On A.GoalID = B.ParentID
Where A.ParentID = @GoalID
Union All
Select C.GoalID, C.ParentID, C.GoalName, C.Description, C.Qty From Goal As A
Join Goal As B On A.GoalID = B.ParentID
Join Goal As C On B.GoalID = C.ParentID
Where A.ParentID = @GoalID
Union All
Select D.GoalID, D.ParentID, D.GoalName, D.Description, D.Qty From Goal As A
Join Goal As B On A.GoalID = B.ParentID
Join Goal As C On B.GoalID = C.ParentID
Join Goal As D On C.GoalID = D.ParentID
Where A.ParentID = @GoalID
Order By GoalName

GO