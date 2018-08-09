EXEC [dbo].pts_CheckProc 'pts_Task_ListProjectMemberStarted'
GO

CREATE PROCEDURE [dbo].pts_Task_ListProjectMemberStarted
   @ProjectID int ,
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT      ta.TaskID, 
         ta.TaskName, 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
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
WHERE (ta.ProjectID = @ProjectID)
 AND (ta.MemberID = @MemberID)
 AND (ta.ActStartDate >= @FromDate)
 AND (ta.ActStartDate <= @ToDate)
 AND (ta.Status = 1)

ORDER BY   ta.ActStartDate

GO