EXEC [dbo].pts_CheckProc 'pts_Issue_ReportStatusDetail'
GO

CREATE PROCEDURE [dbo].pts_Issue_ReportStatusDetail
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Status int
AS

SET NOCOUNT ON

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
AND   zis.Status = @Status
AND   zis.ChangeDate >= @ReportFromDate
AND   zis.ChangeDate <= @ReportToDate
ORDER BY zis.Priority, zic.IssueCategoryName

GO