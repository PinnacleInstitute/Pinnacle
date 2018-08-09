EXEC [dbo].pts_CheckProc 'pts_Task_Projects'
GO

CREATE PROCEDURE [dbo].pts_Task_Projects
   @ProjectID int 

AS

Select T.TaskID, T.ProjectID, T.ParentID, T.TaskName, T.Seq From Task AS T
Where T.ProjectID = @ProjectID
Union All
Select T.TaskID, T.ProjectID, T.ParentID, T.TaskName, T.Seq From Task AS T
Join Project As A On T.ProjectID = A.ProjectID
Where A.ParentID = @ProjectID
Union All
Select T.TaskID, T.ProjectID, T.ParentID, T.TaskName, T.Seq From Task AS T
Join Project As A On T.ProjectID = A.ProjectID
Join Project As B On A.ParentID = B.ProjectID
Where B.ParentID = @ProjectID
Union All
Select T.TaskID, T.ProjectID, T.ParentID, T.TaskName, T.Seq From Task AS T
Join Project As A On T.ProjectID = A.ProjectID
Join Project As B On A.ParentID = B.ProjectID
Join Project As C On B.ParentID = C.ProjectID
Where C.ParentID = @ProjectID
Order By T.Seq

GO