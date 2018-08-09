EXEC [dbo].pts_CheckProc 'pts_Issue_ReportOutsource'
GO

--EXEC pts_Issue_ReportOutsource 17, '1/1/14', '9/24/15'

CREATE PROCEDURE [dbo].pts_Issue_ReportOutsource
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime 
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
    zis.Variance 'Variance' ,
    zis.Rating 'Rating' ,
    zis.Notes 'Notes'
FROM Issue AS zis (NOLOCK)
LEFT OUTER JOIN IssueCategory AS zic (NOLOCK) ON (zic.IssueCategoryID = zis.IssueCategoryID)
WHERE zis.CompanyID = @CompanyID
AND   zis.IssueDate >= @ReportFromDate
AND   zis.IssueDate <= @ReportToDate
AND   zis.Outsource != ''
AND   zis.Status < 4
ORDER BY zis.Outsource

GO
