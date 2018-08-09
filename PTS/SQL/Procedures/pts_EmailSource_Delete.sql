EXEC [dbo].pts_CheckProc 'pts_EmailSource_Delete'
 GO

CREATE PROCEDURE [dbo].pts_EmailSource_Delete ( 
   @EmailSourceID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ems
FROM EmailSource AS ems
WHERE ems.EmailSourceID = @EmailSourceID

GO