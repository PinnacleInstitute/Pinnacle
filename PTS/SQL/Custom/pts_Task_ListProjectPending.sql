EXEC [dbo].pts_CheckProc 'pts_Task_ListProjectPending'
GO

CREATE PROCEDURE [dbo].pts_Task_ListProjectPending
   @ProjectID int
AS

SET NOCOUNT ON

SELECT T.TaskID, T.TaskName, M.NameFirst+' '+M.NameLast 'MemberName', T.Description, T.Status, T.EstStartDate, T.ActStartDate, T.VarStartDate, 
       T.EstEndDate, T.ActEndDate, T.VarEndDate, T.EstCost, T.TotCost, T.IsMilestone FROM Task AS T (NOLOCK)
LEFT OUTER JOIN Member As M On T.MemberID = M.MemberID
WHERE T.ProjectID = @ProjectID AND T.MemberID <> 0 AND T.Status = 0
Union All
SELECT T.TaskID, T.TaskName, M.NameFirst+' '+M.NameLast 'MemberName', T.Description, T.Status, T.EstStartDate, T.ActStartDate, T.VarStartDate, 
       T.EstEndDate, T.ActEndDate, T.VarEndDate, T.EstCost, T.TotCost, T.IsMilestone FROM Task AS T (NOLOCK)
LEFT OUTER JOIN Member As M On T.MemberID = M.MemberID
Join Project As A On T.ProjectID = A.ProjectID
WHERE A.ParentID = @ProjectID AND T.MemberID <> 0 AND T.Status = 0
Union All
SELECT T.TaskID, T.TaskName, M.NameFirst+' '+M.NameLast 'MemberName', T.Description, T.Status, T.EstStartDate, T.ActStartDate, T.VarStartDate, 
       T.EstEndDate, T.ActEndDate, T.VarEndDate, T.EstCost, T.TotCost, T.IsMilestone FROM Task AS T (NOLOCK)
LEFT OUTER JOIN Member As M On T.MemberID = M.MemberID
Join Project As A On T.ProjectID = A.ProjectID
Join Project As B On A.ParentID = B.ProjectID
WHERE B.ParentID = @ProjectID AND T.MemberID <> 0 AND T.Status = 0
Union All
SELECT T.TaskID, T.TaskName, M.NameFirst+' '+M.NameLast 'MemberName', T.Description, T.Status, T.EstStartDate, T.ActStartDate, T.VarStartDate, 
       T.EstEndDate, T.ActEndDate, T.VarEndDate, T.EstCost, T.TotCost, T.IsMilestone FROM Task AS T (NOLOCK)
LEFT OUTER JOIN Member As M On T.MemberID = M.MemberID
Join Project As A On T.ProjectID = A.ProjectID
Join Project As B On A.ParentID = B.ProjectID
Join Project As C On B.ParentID = C.ProjectID
WHERE C.ParentID = @ProjectID AND T.MemberID <> 0 AND T.Status = 0

ORDER BY T.TaskID

GO