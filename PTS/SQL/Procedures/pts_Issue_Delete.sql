EXEC [dbo].pts_CheckProc 'pts_Issue_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Issue_Delete ( 
   @IssueID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE zis
FROM Issue AS zis
WHERE zis.IssueID = @IssueID

GO