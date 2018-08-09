EXEC [dbo].pts_CheckProc 'pts_Task_PastDue'
GO

CREATE PROCEDURE [dbo].pts_Task_PastDue
   @EstEndDate datetime
AS

SET NOCOUNT ON

DECLARE @Now datetime

IF @EstEndDate = 0
	SET @EstEndDate = DATEADD(day, -1, @EstEndDate) 

SELECT   ta.TaskID, 
         ta.TaskName, 
         pr.ProjectName, 
         ISNULL(me.NameFirst + ' ' + me.NameLast,'') AS 'MemberName', 
         ta.Description, 
         ta.EstEndDate,
         ISNULL(me.Email + ';' + m2.Email,'') AS 'Email',
         ISNULL(me.MemberID,0) AS 'MemberID',
         ISNULL(me.IsMsg,0) AS 'IsMsg',
         ISNULL(co.Email,'') AS 'FromEmail' 
FROM Task AS ta
LEFT OUTER JOIN Project AS pr ON ta.ProjectID = pr.ProjectID
LEFT OUTER JOIN Member AS me ON ta.MemberID = me.MemberID
LEFT OUTER JOIN Member AS m2 ON pr.MemberID = me.MemberID
LEFT OUTER JOIN Company AS co ON me.CompanyID = co.CompanyID
WHERE dbo.wtfn_DateOnly(ta.EstEndDate) = @EstEndDate
AND ta.Status < 2

GO
