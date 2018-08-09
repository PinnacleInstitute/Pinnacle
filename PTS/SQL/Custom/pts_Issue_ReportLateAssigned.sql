EXEC [dbo].pts_CheckProc 'pts_Issue_ReportLateAssigned'
GO

CREATE PROCEDURE [dbo].pts_Issue_ReportLateAssigned
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @AssignedTo nvarchar (15) 
AS

SET NOCOUNT ON

DECLARE @mNow datetime
SET @mNow = GETDATE()

SELECT 
    zis.IssueID 'IssueID' ,
    zis.IssueName 'IssueName' ,
    zic.IssueCategoryName 'IssueCategoryName' ,
    zis.Priority 'Priority' ,
    zis.IssueDate 'IssueDate' ,
    zis.SubmittedBy 'SubmittedBy' ,
    zis.AssignedTo 'AssignedTo' ,
    zis.Outsource 'Outsource' ,
    zis.Status 'Status' ,
    zis.ChangeDate 'ChangeDate' ,
    zis.DueDate 'DueDate' ,
    zis.DoneDate 'DoneDate' ,
    zis.Variance 'Variance' 
FROM Issue AS zis (NOLOCK)
LEFT OUTER JOIN IssueCategory AS zic (NOLOCK) ON (zic.IssueCategoryID = zis.IssueCategoryID)
WHERE zis.CompanyID = @CompanyID
AND   zis.DueDate >= @ReportFromDate
AND   zis.DueDate <= @ReportToDate
AND   zis.AssignedTo = @AssignedTo
AND   (zis.Variance > 0 OR (zis.Status < 3 AND DATEDIFF( day, zis.DueDate, @mNow) > 0 ) )
ORDER BY zis.DueDate

GO