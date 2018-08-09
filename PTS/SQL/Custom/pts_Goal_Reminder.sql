EXEC [dbo].pts_CheckProc 'pts_Goal_Reminder'
GO

CREATE PROCEDURE [dbo].pts_Goal_Reminder
   @RemindDate datetime
AS

SET NOCOUNT ON

SELECT   go.GoalID, 
         go.GoalName, 
         go.Description, 
         go.ParentID, 
         go.CommitDate, 
         me.Email AS 'Email', 
         me.MemberID AS 'MemberID', 
         me.IsMsg AS 'IsMsg', 
         co.Email AS 'FromEmail', 
         pr.ProspectName AS 'ProspectName', 
         gp.GoalName AS 'MemberName'
FROM Goal AS go
LEFT OUTER JOIN Goal AS gp ON go.ParentID = gp.GoalID
LEFT OUTER JOIN Member AS me ON go.MemberID = me.MemberID
LEFT OUTER JOIN Company AS co ON me.CompanyID = co.CompanyID
LEFT OUTER JOIN Prospect AS pr ON go.ProspectID = pr.ProspectID
WHERE go.RemindDate = @RemindDate
AND go.Status = 2

GO
