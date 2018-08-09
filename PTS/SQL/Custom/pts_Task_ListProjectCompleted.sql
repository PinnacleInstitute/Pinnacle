EXEC [dbo].pts_CheckProc 'pts_Task_ListProjectCompleted'
GO

CREATE PROCEDURE [dbo].pts_Task_ListProjectCompleted
   @ProjectID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT T.TaskID, T.TaskName, M.NameFirst+' '+M.NameLast 'MemberName', T.Description, T.Status, T.EstStartDate, T.ActStartDate, T.VarStartDate, 
       T.EstEndDate, T.ActEndDate, T.VarEndDate, T.EstCost, T.TotCost, T.IsMilestone FROM Task AS T (NOLOCK)
LEFT OUTER JOIN Member As M On T.MemberID = M.MemberID
WHERE T.ProjectID = @ProjectID AND T.ActEndDate >= @FromDate AND T.ActEndDate <= @ToDate AND T.Status = 2
Union All
SELECT T.TaskID, T.TaskName, M.NameFirst+' '+M.NameLast 'MemberName', T.Description, T.Status, T.EstStartDate, T.ActStartDate, T.VarStartDate, 
       T.EstEndDate, T.ActEndDate, T.VarEndDate, T.EstCost, T.TotCost, T.IsMilestone FROM Task AS T (NOLOCK)
LEFT OUTER JOIN Member As M On T.MemberID = M.MemberID
Join Project As A On T.ProjectID = A.ProjectID
WHERE A.ParentID = @ProjectID AND T.ActEndDate >= @FromDate AND T.ActEndDate <= @ToDate AND T.Status = 2
Union All
SELECT T.TaskID, T.TaskName, M.NameFirst+' '+M.NameLast 'MemberName', T.Description, T.Status, T.EstStartDate, T.ActStartDate, T.VarStartDate, 
       T.EstEndDate, T.ActEndDate, T.VarEndDate, T.EstCost, T.TotCost, T.IsMilestone FROM Task AS T (NOLOCK)
LEFT OUTER JOIN Member As M On T.MemberID = M.MemberID
Join Project As A On T.ProjectID = A.ProjectID
Join Project As B On A.ParentID = B.ProjectID
WHERE B.ParentID = @ProjectID AND T.ActEndDate >= @FromDate AND T.ActEndDate <= @ToDate AND T.Status = 2
Union All
SELECT T.TaskID, T.TaskName, M.NameFirst+' '+M.NameLast 'MemberName', T.Description, T.Status, T.EstStartDate, T.ActStartDate, T.VarStartDate, 
       T.EstEndDate, T.ActEndDate, T.VarEndDate, T.EstCost, T.TotCost, T.IsMilestone FROM Task AS T (NOLOCK)
LEFT OUTER JOIN Member As M On T.MemberID = M.MemberID
Join Project As A On T.ProjectID = A.ProjectID
Join Project As B On A.ParentID = B.ProjectID
Join Project As C On B.ParentID = C.ProjectID
WHERE C.ParentID = @ProjectID AND T.ActEndDate >= @FromDate AND T.ActEndDate <= @ToDate AND T.Status = 2

ORDER BY T.ActEndDate

GO