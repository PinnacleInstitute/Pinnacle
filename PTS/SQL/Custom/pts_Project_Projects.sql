EXEC [dbo].pts_CheckProc 'pts_Project_Projects'
GO

CREATE PROCEDURE [dbo].pts_Project_Projects
   @ProjectID int 

AS

Select A.ProjectID, A.ParentID, A.ProjectName, A.Seq From Project As A
Where A.ParentID = @ProjectID
Union All
Select B.ProjectID, B.ParentID, B.ProjectName, B.Seq From Project As A
Join Project As B On A.ProjectID = B.ParentID
Where A.ParentID = @ProjectID
Union All
Select C.ProjectID, C.ParentID, C.ProjectName, C.Seq From Project As A
Join Project As B On A.ProjectID = B.ParentID
Join Project As C On B.ProjectID = C.ParentID
Where A.ParentID = @ProjectID
Union All
Select D.ProjectID, D.ParentID, D.ProjectName, D.Seq From Project As A
Join Project As B On A.ProjectID = B.ParentID
Join Project As C On B.ProjectID = C.ParentID
Join Project As D On C.ProjectID = D.ParentID
Where A.ParentID = @ProjectID
Order By Seq

GO