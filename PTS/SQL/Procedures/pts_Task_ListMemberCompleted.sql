EXEC [dbo].pts_CheckProc 'pts_Task_ListMemberCompleted'
GO

CREATE PROCEDURE [dbo].pts_Task_ListMemberCompleted
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
WHERE (ta.MemberID = @MemberID)
 AND (ta.ActEndDate >= @FromDate)
 AND (ta.ActEndDate <= @ToDate)
 AND (ta.Status = 2)

ORDER BY   ta.ActEndDate

GO