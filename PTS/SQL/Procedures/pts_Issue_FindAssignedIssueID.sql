EXEC [dbo].pts_CheckProc 'pts_Issue_FindAssignedIssueID'
 GO

CREATE PROCEDURE [dbo].pts_Issue_FindAssignedIssueID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @AssignedTo nvarchar (15),
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), zis.IssueID), '') + dbo.wtfn_FormatNumber(zis.IssueID, 10) 'BookMark' ,
            zis.IssueID 'IssueID' ,
            zis.CompanyID 'CompanyID' ,
            zis.IssueCategoryID 'IssueCategoryID' ,
            zis.SubmitID 'SubmitID' ,
            zic.IssueCategoryName 'IssueCategoryName' ,
            zic.InputOptions 'InputOptions' ,
            zis.IssueDate 'IssueDate' ,
            zis.IssueName 'IssueName' ,
            zis.SubmittedBy 'SubmittedBy' ,
            zis.SubmitType 'SubmitType' ,
            zis.Priority 'Priority' ,
            zis.Description 'Description' ,
            zis.AssignedTo 'AssignedTo' ,
            zis.Status 'Status' ,
            zis.Notes 'Notes' ,
            zis.ChangeDate 'ChangeDate' ,
            zis.DueDate 'DueDate' ,
            zis.DoneDate 'DoneDate' ,
            zis.Variance 'Variance' ,
            zis.InputValues 'InputValues' ,
            zis.Rating 'Rating' ,
            zis.Outsource 'Outsource'
FROM Issue AS zis (NOLOCK)
LEFT OUTER JOIN IssueCategory AS zic (NOLOCK) ON (zic.IssueCategoryID = zis.IssueCategoryID)
WHERE ISNULL(CONVERT(nvarchar(10), zis.IssueID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), zis.IssueID), '') + dbo.wtfn_FormatNumber(zis.IssueID, 10) >= @BookMark
AND         (zis.AssignedTo = @AssignedTo)
ORDER BY 'Bookmark'

GO