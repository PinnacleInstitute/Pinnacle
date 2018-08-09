EXEC [dbo].pts_CheckProc 'pts_Task_ListProject'
GO

CREATE PROCEDURE [dbo].pts_Task_ListProject
   @ProjectID int
AS

SET NOCOUNT ON

SELECT      ta.TaskID, 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
         ta.TaskName, 
         ta.Description, 
         ta.Status, 
         ta.Seq, 
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
WHERE (ta.ProjectID = @ProjectID)
 AND (ta.ParentID = 0)

ORDER BY   ta.Seq

GO