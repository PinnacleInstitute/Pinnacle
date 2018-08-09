EXEC [dbo].pts_CheckProc 'pts_Goal_ReportMember'
GO

--EXEC pts_Goal_ReportMember 20, '1/1/2000', '1/1/06', 0, 0

CREATE PROCEDURE [dbo].pts_Goal_ReportMember
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @GoalType int ,
   @Priority int 
AS

SET NOCOUNT ON

SELECT go.GoalID, 
       go.MemberID, 
       go.ParentID, 
       go.AssignID, 
       LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) 'AssignName' ,
       go.GoalName, 
       go.Description, 
       go.GoalType, 
       go.Priority, 
       go.Status, 
       go.CommitDate, 
       go.CompleteDate, 
       go.Variance
FROM Goal AS go (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (go.AssignID = au.AuthUserID)
WHERE go.MemberID = @MemberID
AND   go.CommitDate >= @FromDate
AND   go.CommitDate <= @ToDate
AND ( @GoalType = 0 OR go.GoalType = @GoalType )
AND ( @Priority = 0 OR go.Priority = @Priority )
AND   go.Status = 3
ORDER BY go.CompleteDate DESC, go.CommitDate DESC, go.GoalID

GO