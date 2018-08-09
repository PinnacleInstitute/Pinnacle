EXEC [dbo].pts_CheckProc 'pts_Issue_FindAssignedIssueCategoryName'
 GO

CREATE PROCEDURE [dbo].pts_Issue_FindAssignedIssueCategoryName ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (30),
   @MaxRows tinyint OUTPUT,
   @AssignedTo nvarchar (15),
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(zic.IssueCategoryName, '') + dbo.wtfn_FormatNumber(zis.IssueID, 10) 'BookMark' ,
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
WHERE ISNULL(zic.IssueCategoryName, '') LIKE @SearchText + '%'
AND ISNULL(zic.IssueCategoryName, '') + dbo.wtfn_FormatNumber(zis.IssueID, 10) >= @BookMark
AND         (zis.AssignedTo = @AssignedTo)
ORDER BY 'Bookmark'

GO