EXEC [dbo].pts_CheckProc 'pts_Project_WhatsNew'
GO

CREATE PROCEDURE [dbo].pts_Project_WhatsNew
   @ProjectID int,
   @FromDate datetime,
   @ToDate datetime
AS

SET NOCOUNT ON

-- Add 1 day to the Todate for Notes and Messages which stores minutes
DECLARE @tmpToDate datetime, @CompanyID int, @Hierarchy varchar(30) 
SET @tmpToDate = DATEADD(day, 1, @ToDate)

SELECT @CompanyID = CompanyID, @Hierarchy = Hierarchy FROM Project WHERE ProjectID = @ProjectID

SELECT  pr.ProjectID, 
        pr.ProjectName, 
        me.NameFirst + ' ' + me.NameLast 'MemberName', 
        pj.ProjectName 'Description',
        pr.Status, 
        pr.ActStartDate, 
        pr.VarStartDate, 
        pr.ActEndDate, 
        pr.VarEndDate, 
	(
		SELECT COUNT(*) FROM Note 
		WHERE OwnerType = 75 AND OwnerID = pr.ProjectID
		AND NoteDate >= @FromDate AND NoteDate <= @tmpToDate
	) 'Notes',
	(
		SELECT COUNT(*) FROM Attachment 
		WHERE ParentType = 75 AND ParentID = pr.ProjectID
		AND AttachDate >= @FromDate AND AttachDate <= @ToDate
	) 'Documents',
	(
		SELECT COUNT(*) FROM Message 
		WHERE ForumID = pr.ForumID
		AND ChangeDate >= @FromDate AND ChangeDate <= @tmpToDate
	) 'Messages',
        pr.ForumID, 
        pr.IsForum, 
        pr.IsChat 
FROM Project AS pr (NOLOCK)
LEFT OUTER JOIN Project AS pj ON pr.ParentID = pj.ProjectID
LEFT OUTER JOIN Member AS me ON pr.MemberID = me.MemberID
--WHERE (pr.ProjectID = @ProjectID)
WHERE pr.CompanyID = @CompanyID AND pr.Hierarchy LIKE @Hierarchy + '%'
AND   ((pr.ActStartDate >= @FromDate AND pr.ActStartDate <= @ToDate)
OR     (pr.ActEndDate >= @FromDate AND pr.ActEndDate <= @ToDate)
OR     (pr.ChangeDate >= @FromDate AND pr.ChangeDate <= @ToDate)
OR     (
		SELECT COUNT(*) FROM Note 
		WHERE OwnerType = 75 AND OwnerID = pr.ProjectID
		AND NoteDate >= @FromDate AND NoteDate <= @tmpToDate
       ) > 0
OR     (
		SELECT COUNT(*) FROM Attachment 
		WHERE ParentType = 75 AND ParentID = pr.ProjectID
		AND AttachDate >= @FromDate AND AttachDate <= @ToDate
       ) > 0
OR     (
		SELECT COUNT(*) FROM Message 
		WHERE ForumID = pr.ForumID
		AND ChangeDate >= @FromDate AND ChangeDate <= @tmpToDate
       ) > 0
      )
ORDER BY pr.ProjectName

GO
