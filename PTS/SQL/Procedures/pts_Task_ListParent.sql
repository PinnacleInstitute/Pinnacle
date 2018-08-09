EXEC [dbo].pts_CheckProc 'pts_Task_ListParent'
GO

CREATE PROCEDURE [dbo].pts_Task_ListParent
   @ParentID int
AS

SET NOCOUNT ON

SELECT      ta.TaskID, 
         ta.ParentID, 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
         ta.TaskName, 
         ta.Description, 
         ta.Status, 
         ta.EstStartDate, 
         ta.ActStartDate, 
         ta.VarStartDate, 
         ta.EstEndDate, 
         ta.ActEndDate, 
         ta.VarEndDate, 
         ta.EstCost, 
         ta.TotCost, 
         ta.IsMilestone
FROM Task AS ta (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (ta.MemberID = me.MemberID)
WHERE (ta.ParentID = @ParentID)

ORDER BY   ta.Seq

GO