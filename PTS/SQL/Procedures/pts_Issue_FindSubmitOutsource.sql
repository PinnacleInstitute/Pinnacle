EXEC [dbo].pts_CheckProc 'pts_Issue_FindSubmitOutsource'
 GO

CREATE PROCEDURE [dbo].pts_Issue_FindSubmitOutsource ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (30),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @SubmitType int,
   @SubmitID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(zis.Outsource, '') + dbo.wtfn_FormatNumber(zis.IssueID, 10) 'BookMark' ,
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
WHERE ISNULL(zis.Outsource, '') LIKE @SearchText + '%'
AND ISNULL(zis.Outsource, '') + dbo.wtfn_FormatNumber(zis.IssueID, 10) >= @BookMark
AND         (zis.CompanyID = @CompanyID)
AND         (zis.SubmitType = @SubmitType)
AND         (zis.SubmitID = @SubmitID)
ORDER BY 'Bookmark'

GO