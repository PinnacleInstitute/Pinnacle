EXEC [dbo].pts_CheckProc 'pts_IssueCategory_Delete'
 GO

CREATE PROCEDURE [dbo].pts_IssueCategory_Delete ( 
   @IssueCategoryID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE zic
FROM IssueCategory AS zic
WHERE zic.IssueCategoryID = @IssueCategoryID

GO