EXEC [dbo].pts_CheckProc 'pts_EmailList_Delete'
 GO

CREATE PROCEDURE [dbo].pts_EmailList_Delete ( 
   @EmailListID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE eml
FROM EmailList AS eml
WHERE eml.EmailListID = @EmailListID

GO