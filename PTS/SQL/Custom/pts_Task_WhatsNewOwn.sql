EXEC [dbo].pts_CheckProc 'pts_Task_WhatsNewOwn'
GO

CREATE PROCEDURE [dbo].pts_Task_WhatsNewOwn
   @MemberID int,
   @FromDate datetime,
   @ToDate datetime
AS

SET NOCOUNT ON

-- Add 1 day to the Todate for Notes which stores minutes
DECLARE @tmpToDate datetime
SET @tmpToDate = DATEADD(day, 1, @ToDate)

SELECT  ta.TaskID, 
        ta.TaskName, 
        me.NameFirst + ' ' + me.NameLast 'MemberName', 
        pj.ProjectName 'Description',
        ta.Status, 
        ta.ActStartDate, 
        ta.VarStartDate, 
        ta.ActEndDate, 
        ta.VarEndDate, 
	(
		SELECT COUNT(*) FROM Note 
		WHERE OwnerType = 74 AND OwnerID = ta.TaskID
		AND NoteDate >= @FromDate AND NoteDate <= @tmpToDate
	) 'Notes',
	(
		SELECT COUNT(*) FROM Attachment 
		WHERE ParentType = 74 AND ParentID = ta.TaskID
		AND AttachDate >= @FromDate AND AttachDate <= @ToDate
	) 'Documents'
FROM Task AS ta (NOLOCK)
JOIN Project AS pj ON ta.ProjectID = pj.ProjectID
LEFT OUTER JOIN Member AS me ON ta.MemberID = me.MemberID
WHERE (ta.MemberID = @MemberID)
AND   ((ta.ActStartDate >= @FromDate AND ta.ActStartDate <= @ToDate)
OR     (ta.ActEndDate >= @FromDate AND ta.ActEndDate <= @ToDate)
OR     (
		SELECT COUNT(*) FROM Note 
		WHERE OwnerType = 74 AND OwnerID = ta.TaskID
		AND NoteDate >= @FromDate AND NoteDate <= @tmpToDate
       ) > 0
OR     (
		SELECT COUNT(*) FROM Attachment 
		WHERE ParentType = 74 AND ParentID = ta.TaskID
		AND AttachDate >= @FromDate AND AttachDate <= @ToDate
       ) > 0
      )
ORDER BY ta.TaskName

GO
